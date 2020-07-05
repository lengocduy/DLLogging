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
    let file: String

    /// The function where this log message was created
    let function: String

    /// The text of the log message
    let text: String

    /// The level of the log message
    let level: LogLevel
    
    /// The line of the log message
    let line: Int
    
    /// The value to know whether need to sync with other system or not
    let isAllowedSyncToCloud: Bool

    init(path: String, function: String,
         text: String, level: LogLevel,
         line: Int, isAllowedSyncToCloud: Bool = false) {
        if let file = path.components(separatedBy: "/").last {
            self.file = file
        } else {
            self.file = path
        }
        self.function = function
        self.text = text
        self.level = level
        self.line = line
        self.isAllowedSyncToCloud = isAllowedSyncToCloud
    }
}
