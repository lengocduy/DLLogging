//
//  FileLogging.swift
//  Logging
//
//  Created by Duy Le Ngoc on 7/6/20.
//  Copyright © 2020 Duy Le Ngoc. All rights reserved.
//

import Foundation

// MARK: - FileLogging
final class FileLogging: BaseLogging {
    /// An object-oriented wrapper for a file descriptor.
    private let fileHandle: FileHandle
    
    /// The path to file log
    private var filePath: String
    
    /// Delegate handling new data coming to client
    private weak var delegate: FileLoggingDelegate?
    
    init(logFormatter: LogFormatter? = nil, delegate: FileLoggingDelegate? = nil) {
        var fileName = "FileLogging"
        if let fileLoggingDelegate = delegate {
            fileName = fileLoggingDelegate.logFileName
        }
        
        /// create a file if it does not exist
        filePath = FileLogging.getPathFileName(fileName)
        FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil)
        if let handle = FileHandle(forWritingAtPath: filePath) {
            fileHandle = handle
        } else {
            fileHandle = FileHandle.standardError
        }
        
        /// Register handling flush data
        self.delegate = delegate

        /// Move to the end of the file so we can append messages
        fileHandle.seekToEndOfFile()
        
        /// Designated initializer must always delegate up to Designated initializer superclass
        super.init(logFormatter: logFormatter)
        
        /// Setup synchronization with Client
        setupSynchronizedSchedule()
    }

    deinit {
        /// Ensure we close the file handle to clear the resources
        fileHandle.closeFile()
    }

    override func receiveMessage(_ message: LogMessage) {
        let time = Date().stringByFormat(.iso8601)
        var formattedMessage = "\(message.level.symbol) \(time): [\(message.file)]:\(message.function):\(message.line): \(message.text)"
        if let logFormatter = logFormatter {
            formattedMessage = logFormatter.formatMessage(message)
        }
        
        if let data = formattedMessage.data(using: String.Encoding.utf8) {
            /// Write the message as data to the file
            fileHandle.write(data)
        }
    }
    
    override func reset() {
        clearData()
        fileHandle.seek(toFileOffset: 0)
    }
}

// MARK: - Private Extension
private extension FileLogging {
    ///get the default log directory
    static func getPathFileName(_ fileName: String) -> String {
        #if os(iOS)
        return FileManager
            .default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .last?
            .appendingPathComponent("\(fileName).log")
            .path  ?? ""
        #elseif os(macOS)
        return FileManager
            .default
            .urls(for: .libraryDirectory, in: .userDomainMask).last?
            .appendingPathComponent("\(fileName).log")
            .path ?? ""
        #endif
    }
    
    var flushData: Data? {
        do {
            let content = try String(contentsOf: URL(fileURLWithPath: filePath), encoding: .utf8)
            if content.isEmpty {
                return nil
            }
            return Data(content.utf8)
        } catch _ {
            return nil
        }
    }
    
    func clearData() {
        do {
            try "".write(to: URL(fileURLWithPath: filePath), atomically: false, encoding: .utf8)
        } catch {}
    }
    
    /// Setup synchronization back to Client
    func setupSynchronizedSchedule() {
        guard let fileLoggingDelegate = delegate else {
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: fileLoggingDelegate.flushInterval, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            let formattedDate = Date().stringByFormat(.logByDate)
            let formattedTime = Date().stringByFormat(.logByTime)
            fileLoggingDelegate.receiveData(self.flushData, on: formattedDate, at: formattedTime)

            self.reset()
        }
    }
}
