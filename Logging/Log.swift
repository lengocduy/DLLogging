//
//  Log.swift
//  Logging
//
//  Created by Duy Le Ngoc on 7/11/20.
//  Copyright © 2020 Duy Le Ngoc. All rights reserved.
//

import Foundation

/// This enum exposes functions that were invoked by Client.
public enum Log {
    /// Log when working on a specific problem.
    ///
    /// - parameters:
    ///     - message: content that client want to print.
    ///     - path: file name invoke the log.
    ///     - function: function name invoke the log.
    ///     - line: specify line invoke the log.
    ///
    /// - returns: Void.
    public static func verbose(message: String, path: String = #file,
                               function: String = #function, line: Int = #line) {
        LoggerManager.sharedInstance.log(.verbose, message: message, path: path, function: function, line: line)
    }
    
    /// Log to help developer.
    ///
    /// - parameters:
    ///     - message: content that client want to print.
    ///     - path: file name invoke the log.
    ///     - function: function name invoke the log.
    ///     - line: specify line invoke the log.
    ///
    /// - returns: Void.
    public static func debug(message: String, path: String = #file,
                             function: String = #function, line: Int = #line) {
        LoggerManager.sharedInstance.log(.debug, message: message, path: path, function: function, line: line)
    }
    
    /// Log to highlight the progress of the application at coarse-grained level.
    ///
    /// - parameters:
    ///     - message: content that client want to print.
    ///     - path: file name invoke the log.
    ///     - function: function name invoke the log.
    ///     - line: specify line invoke the log.
    ///
    /// - returns: Void.
    public static func info(message: String, path: String = #file,
                            function: String = #function, line: Int = #line) {
        LoggerManager.sharedInstance.log(.info, message: message, path: path, function: function, line: line)
    }
    
    /// Log to indicate a possible error.
    ///
    /// - parameters:
    ///     - message: content that client want to print.
    ///     - path: file name invoke the log.
    ///     - function: function name invoke the log.
    ///     - line: specify line invoke the log.
    ///
    /// - returns: Void.
    public static func warning(message: String, path: String = #file,
                               function: String = #function, line: Int = #line) {
        LoggerManager.sharedInstance.log(.warning, message: message, path: path, function: function, line: line)
    }
    
    /// Log an error occurred, but it's recoverable, just info about what happened.
    ///
    /// - parameters:
    ///     - message: content that client want to print.
    ///     - path: file name invoke the log.
    ///     - function: function name invoke the log.
    ///     - line: specify line invoke the log.
    ///
    /// - returns: Void.
    public static func error(message: String, path: String = #file,
                             function: String = #function, line: Int = #line) {
        LoggerManager.sharedInstance.log(.error, message: message, path: path, function: function, line: line)
    }
    
    /// Log a server error occurred.
    ///
    /// - parameters:
    ///     - message: content that client want to print.
    ///     - path: file name invoke the log.
    ///     - function: function name invoke the log.
    ///     - line: specify line invoke the log.
    ///
    /// - returns: Void.
    public static func severe(message: String, path: String = #file,
                              function: String = #function, line: Int = #line) {
        LoggerManager.sharedInstance.log(.severe, message: message, path: path, function: function, line: line)
    }
}
