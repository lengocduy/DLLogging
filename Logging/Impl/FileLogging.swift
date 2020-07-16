//
//  FileLogging.swift
//  Logging
//
//  Created by Duy Le Ngoc on 7/6/20.
//  Copyright © 2020 Duy Le Ngoc. All rights reserved.
//

import Foundation

final class FileLogging: BaseLogging {
    private let fileHandle: FileHandle
    
    init(path: String, logFormatter: LogFormatter?) {
        /// create a file if it does not exist
        FileManager.default.createFile(atPath: "\(path).txt", contents: nil, attributes: nil)
        if let handle = FileHandle(forWritingAtPath: path) {
            fileHandle = handle
        } else {
            fileHandle = FileHandle.standardError
        }

        /// Move to the end of the file so we can append messages
        fileHandle.seekToEndOfFile()
        
        /// Designated initializer must always delegate up to Designated initializer superclass
        super.init(logFormatter: logFormatter)
    }

    deinit {
        /// Ensure we close the file handle to clear the resources
        fileHandle.closeFile()
    }

    override func receiveMessage(_ message: LogMessage) {
        guard message.isAllowedSyncToCloud else {
            return
        }
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
        fileHandle.seek(toFileOffset: 0)
    }
}
