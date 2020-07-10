//
//  LoggerManager.swift
//  Logging
//
//  Created by Duy Le Ngoc on 7/6/20.
//  Copyright © 2020 Duy Le Ngoc. All rights reserved.
//

import Foundation

// MARK: - Open Class
open class LoggerManager: LogPublisher {
    public static let sharedInstance = LoggerManager()
    
    public private(set) var loggerFactoryType: LoggerFactory.Type = LoggerFactoryImpl.self
    private(set) var loggers: [Logging] = []
    private var enabledLevels = Set<LogLevel>()
    private let readWriteLock = ReadWriteLock(label: "loggerLock")
    
    private init() {}
    
    /// Set up the default for Log.
    /// Client use this function for quick setup and use default framework.
    ///
    /// - returns: Void
    private func setUpLogger() {
        setUpLoggerFactoryType(LoggerFactoryImpl.self)
        enableLevels(LogLevel.allCases)
        let logFormatter = LogFormatterImpl()
        addLogging(loggerFactoryType.makeConsoleLogging(logFormatter: logFormatter))
        addLogging(loggerFactoryType.makeFileLogging(fileName: "appLogs", logFormatter: logFormatter))
    }
    
    /// Allow Client inject customized its implementation conform to LoggerFactory.
    ///
    /// - parameters:
    ///     - loggerFactoryType: an implementation of LoggerFactory (conform to protocol LoggerFactory).
    ///
    /// - returns: Void.
    open func setUpLoggerFactoryType(_ loggerFactoryType: LoggerFactory.Type) {
        self.loggerFactoryType = loggerFactoryType
    }
}

// MARK: - LogFormatter
struct LogFormatterImpl: LogFormatter {
    public func formatMessage(_ message: LogMessage) -> String {
        return "[\(message.function)]:line:\(message.line):\(message.level.name) \(message.text)"
    }
}

// MARK: - Internal Methods
extension LoggerManager {
    /// Entry point to receive messages forward to internal system from Client.
    ///
    /// It notifies to each registered handlers(Observers) as an Observable (Subject).
    ///
    /// - parameter message: An instance LogMessage need to be handled.
    /// - returns: Void.
    func logMessage(_ message: LogMessage) {
        var loggers = [Logging]()
        readWriteLock.read {
            loggers = self.loggers
        }
        
        loggers.forEach { $0.receiveMessage(message) }
    }
    
    /// Entry point to receive messages from Client.
    ///
    /// - parameters:
    ///     - level: An instance LogLevel.
    ///     - message: content that client want to print.
    ///     - path: file name invoke the log.
    ///     - function: function name invoke the log.
    ///     - line: specify line invoke the log.
    ///
    /// - returns: Void.
    func log(_ level: LogLevel, message: String,
             path: String = #file, function: String = #function, line: Int = #line) {
        let log = LogMessage(path: path, function: function, text: message, level: level, line: line)
        logMessage(log)
    }
}

// MARK: - Public Methods
public extension LoggerManager {
    /// Entry point to access Logger feature.
    func initialize() {
        setUpLogger()
    }
    
    func addLogging(_ logging: Logging) {
        readWriteLock.write {
            loggers.append(logging)
        }
    }
    
    func removeLogging(_ logging: Logging) {
//        if logging {
//            <#code#>
//        }
    }
    
    func resetLogging() {
        readWriteLock.write {
            loggers.removeAll()
        }
    }
    
    /// Enable log messages of a specific `LogLevel` to be added to the log.
    ///
    /// - parameters:
    ///     - levels: an array of LogLevel want to enabled.
    ///
    /// - returns: Void.
    func enableLevels(_ levels: [LogLevel]) {
        readWriteLock.write {
            levels.forEach { enabledLevels.insert($0) }
        }
    }

    /// Disable log messages of a specific `LogLevel` to prevent them from being logged
    func disableLevels(_ levels: [LogLevel]) {
        readWriteLock.write {
            levels.forEach { enabledLevels.remove($0) }
        }
    }
}

// MARK: - Public Methods more declarative
public extension LoggerManager {
    /// Log when working on a specific problem.
    ///
    /// - parameters:
    ///     - message: content that client want to print.
    ///     - path: file name invoke the log.
    ///     - function: function name invoke the log.
    ///     - line: specify line invoke the log.
    ///
    /// - returns: Void.
    func verbose(message: String, path: String = #file,
                 function: String = #function, line: Int = #line) {
        log(.verbose, message: message, path: path, function: function, line: line)
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
    func debug(message: String, path: String = #file,
               function: String = #function, line: Int = #line) {
        log(.debug, message: message, path: path, function: function, line: line)
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
    func info(message: String, path: String = #file,
              function: String = #function, line: Int = #line) {
        log(.info, message: message, path: path, function: function, line: line)
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
    func warning(message: String, path: String = #file,
                 function: String = #function, line: Int = #line) {
        log(.warning, message: message, path: path, function: function, line: line)
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
    func error(message: String, path: String = #file,
               function: String = #function, line: Int = #line) {
        log(.error, message: message, path: path, function: function, line: line)
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
    func severe(message: String, path: String = #file,
                function: String = #function, line: Int = #line) {
        log(.severe, message: message, path: path, function: function, line: line)
    }
}
