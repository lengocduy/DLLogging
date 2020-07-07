//
//  LoggerManager.swift
//  Logging
//
//  Created by Duy Le Ngoc on 7/6/20.
//  Copyright © 2020 Duy Le Ngoc. All rights reserved.
//

import Foundation

class LoggerManager: LogPublisher {
    static let sharedInstance = LoggerManager()
    
    private(set) var loggers: [Logging] = []
    private var enabledLevels = Set<LogLevel>()
    private let readWriteLock = ReadWriteLock(label: "loggerLock")
    
    private init() {}
    
    func addLogging(_ logging: Logging) {
        loggers.append(logging)
    }
    
    func removeLogging(_ logging: Logging) {
//        if logging {
//            <#code#>
//        }
    }
    
    /// Entry point to receive messages from Client.
    /// Then, It notifies to each registered handlers(Observers) as an Observable (Subject).
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
    
    /// Enable log messages of a specific `LogLevel` to be added to the log
    func enableLevel(_ level: LogLevel) {
        readWriteLock.write {
            enabledLevels.insert(level)
        }
    }

    /// Disable log messages of a specific `LogLevel` to prevent them from being logged
    func disableLevel(_ level: LogLevel) {
        readWriteLock.write {
            enabledLevels.remove(level)
        }
    }
}
