//
//  LogFormatter.swift
//  Logging
//
//  Created by Duy Le Ngoc on 7/6/20.
//  Copyright © 2020 Duy Le Ngoc. All rights reserved.
//

import Foundation

// MARK: - LogFormatter Decorator
public protocol LogFormatter {
    /// Custom format a message an instance of `LogMessage`.
    ///
    /// - parameter message: An instance of LogMessage.
    /// - returns: a formatted message as String.
    func formatMessage(_ message: LogMessage) -> String
}
