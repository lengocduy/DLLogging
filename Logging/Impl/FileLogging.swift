//
//  FileLogging.swift
//  Logging
//
//  Created by Duy Le Ngoc on 7/6/20.
//  Copyright © 2020 Duy Le Ngoc. All rights reserved.
//

import Foundation

final class FileLogging: Logging {
    private let fileHandle: FileHandle
    private(set )var logFormatter: LogFormatter?
    
    init(path: String, logFormatter: LogFormatter?) {
        /// create a file if it does not exist
        FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
        if let handle = FileHandle(forWritingAtPath: path) {
            fileHandle = handle
        } else {
            fileHandle = FileHandle.standardError
        }

        /// Move to the end of the file so we can append messages
        fileHandle.seekToEndOfFile()
        
        /// Allow client customizing message
        self.logFormatter = logFormatter
    }

    deinit {
        /// Ensure we close the file handle to clear the resources
        fileHandle.closeFile()
    }

    func receiveMessage(_ message: LogMessage) {
        guard message.isAllowedSyncToCloud else {
            return
        }
        let time = Date().stringByFormat(.iso8601)
        var formattedMessage = "[\(time)] : [\(message.file)] -> \(message.function) at line \(message.line): \(message.text)\n"
        if let logFormatter = logFormatter {
            formattedMessage = "[\(time)] : \(logFormatter.formatMessage(message))"
        }
        
        if let data = formattedMessage.data(using: String.Encoding.utf8) {
            /// Write the message as data to the file
            fileHandle.write(data)
        }
    }
    
    func reset() {
        fileHandle.seek(toFileOffset: 0)
    }
}

@available(iOS 13, *)
extension FileLogging: Identifiable {}
