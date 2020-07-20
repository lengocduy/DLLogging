//
//  LogMessage.swift
//  Logging
//
//  Created by Duy Le Ngoc on 7/6/20.
//  Copyright © 2020 Duy Le Ngoc. All rights reserved.
//

import Foundation

/// This holds all the data for each log message, since the formatting is up to each
/// logging object. It is a simple bag of data
// MARK: - LogMessage
public struct LogMessage {
    /// The file where this log message was created
    public let file: String

    /// The function where this log message was created
    public let function: String

    /// The text of the log message
    public let text: String

    /// The level of the log message
    public let level: LogLevel
    
    /// The line of the log message
    public let line: Int

    init(path: String, function: String,
         text: String, level: LogLevel,
         line: Int) {
        if let file = path.components(separatedBy: "/").last {
            self.file = file
        } else {
            self.file = path
        }
        self.function = function
        self.text = text
        self.level = level
        self.line = line
    }
}
