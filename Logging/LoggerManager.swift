//
//  LoggerManager.swift
//  Logging
//
//  Created by Duy Le Ngoc on 7/6/20.
//  Copyright © 2020 Duy Le Ngoc. All rights reserved.
//

import Foundation

// MARK: - LogFormatter Default
public struct LogFormatterImpl: LogFormatter {
    public init() {}
    
    public func formatMessage(_ message: LogMessage) -> String {
        let time = Date().stringByFormat(.iso8601)
        return "\(time) [\(message.level.symbol)][\(getLogLocation(message))] -> \(message.text)"
    }
    
    /// Logs detail location of file at a line call log method. It only uses internally
    ///
    /// - Author:
    ///   Duy Le Ngoc
    ///
    /// - parameters:
    ///     - file: The name of the file calls this method.
    ///     - line: The line of the code calls this method.
    ///
    /// - returns: Void
    func getLogLocation(_ message: LogMessage) -> String {
        let substrings = message.file.components(separatedBy: "/")
        return "\(substrings.last ?? ""):\(message.line):\(message.function)"
    }
}

// MARK: - Open Class
open class LoggerManager: LogPublisher {
    public static let sharedInstance = LoggerManager()
    
    public private(set) var loggerFactoryType: LoggerFactory.Type = LoggerFactoryImpl.self
    private(set) var loggers: [BaseLogging] = []
    private var enabledLevels = Set<LogLevel>(LogLevel.allCases)
    private let readWriteLock = ReadWriteLock(label: "loggerLock")
    
    private init() {}
    
    /// Set up the default for Log.
    /// Client use this function for quick setup and use default framework.
    ///
    /// - returns: Void
    private func setUpLogger() {
        setUpLoggerFactoryType(LoggerFactoryImpl.self)
        let logFormatter = LogFormatterImpl()
        let consoleLogging = loggerFactoryType.makeConsoleLogging(logFormatter: logFormatter) as! PrintLogging
        addLogging(consoleLogging)
        addLogging(loggerFactoryType.makeConsoleDebugLogging(logFormatter: logFormatter))
        addLogging(loggerFactoryType.makeFileLogging(logFormatter: logFormatter, delegate: nil))
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
        var enabledLevels = Set<LogLevel>()
        readWriteLock.read {
            enabledLevels = self.enabledLevels
        }
        guard enabledLevels.contains(level) else { return }
        
        let log = LogMessage(path: path, function: function, text: message, level: level, line: line)
        logMessage(log)
    }
    
    /// Enable log of an array of `LogLevels` to be added to the log.
    ///
    /// - parameters:
    ///     - levels: an array of LogLevel want to enabled.
    ///
    /// - returns: Void.
    func enableLogLevels(_ levels: [LogLevel]) {
        readWriteLock.write {
            levels.forEach { enabledLevels.insert($0) }
        }
    }
}

// MARK: - Public Methods
public extension LoggerManager {
    /// Entry point to access Logger feature.
    func initialize() {
        enableLogLevels(LogLevel.allCases)
        setUpLogger()
    }
    
    /// Add an implementation of `Logging` to a list of registered handlers.
    ///
    /// - parameter logging: An implementation of Logging.
    /// - returns: Void.
    func addLogging(_ logging: BaseLogging) {
        readWriteLock.write {
            loggers.append(logging)
        }
    }
    
    /// Remove an implemation `Logging` from a list of registered handlers.
    ///
    /// - parameter logging: An implementation of Logging.
    /// - returns: Void.
    func removeLogging(_ logging: BaseLogging) {
        readWriteLock.read {
            // swiftlint:disable identifier_name
            for i in 0...loggers.count {
                let currentLogger = loggers[i]

                if logging == currentLogger {
                    loggers.remove(at: i)
                    break
                }
            }
            // swiftlint:enable
        }
    }
    
    /// Clear all registered handlers (observers).
    func clearLogging() {
        readWriteLock.write {
            loggers.removeAll()
        }
    }

    /// Disable log of an array of `LogLevels` to prevent them from being logged
    ///
    /// Disable LogLevels debug and warning
    /// ```
    /// LoggerManager.sharedInstance.disableLevels([.debug, .warning]
    /// ```
    /// Disable all LogLevels
    /// ```
    /// LoggerManager.sharedInstance.disableLevels(LogLevel.allCases)
    /// ```
    /// - parameters:
    ///     - levels: an array of LogLevel want to disabled.
    ///
    /// - returns: Void.
    func disableLogLevels(_ levels: [LogLevel]) {
        readWriteLock.write {
            levels.forEach { enabledLevels.remove($0) }
        }
    }
}
