//
//  LogLevel.swift
//  Logging
//
//  Created by Duy Le Ngoc on 7/6/20.
//  Copyright © 2020 Duy Le Ngoc. All rights reserved.
//

import Foundation

/// This defines the various levels of logging that a message may be tagged with. This allows hiding and
/// showing different logging levels at run time depending on the environment
// MARK: - LogLevel
public enum LogLevel: String, CaseIterable {
    /// Verbose 🗣 - A verbose message, usually useful when working on a specific problem
    case verbose
    
    /// Debug 🔍 - A debug message that may be useful to a developer
    case debug

    /// Info ℹ️ - An info message that highlight the progress of the application at coarse-grained level.
    case info

    /// Warning ⚠️ - A warning message, may indicate a possible error
    case warning

    /// Error ❗️ - An error occurred, but it's recoverable, just info about what happened
    case error
    
    /// Severe 🛑 - A server error occurred
    case severe
    
    var symbol: String {
        switch self {
        case .verbose : return "🗣"
        case .debug : return "🔍"
        case .info : return "ℹ️"
        case .warning : return "⚠️"
        case .error : return "❗️"
        case .severe : return "🛑"
        }
    }
    
    var name: String {
        return "[\(self.rawValue.uppercased())]"
    }
}
