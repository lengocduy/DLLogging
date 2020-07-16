//
//  LogPublisher.swift
//  Logging
//
//  Created by Duy Le Ngoc on 7/6/20.
//  Copyright © 2020 Duy Le Ngoc. All rights reserved.
//

import Foundation

// MARK: - LogPublisher Observable
protocol LogPublisher {
    /// A list of registered handlers or observers with this Observable
    var loggers: [BaseLogging] { get }
    
    /// Add an implementation of `Logging` to a list of registered handlers.
    ///
    /// - parameter logging: An implementation of Logging.
    /// - returns: Void.
    func addLogging(_ logging: BaseLogging)
    
    /// Remove an implemation `Logging` from a list of registered handlers.
    ///
    /// - parameter logging: An implementation of Logging.
    /// - returns: Void.
    func removeLogging(_ logging: BaseLogging)
    
    /// Log a message an instance of `LogMessage`.
    /// Normally, This function was invoked by a Client.
    /// It notifies to each registered handlers(Observers) as an Observable (Subject).
    ///
    /// - parameter message: An instance LogMessage need to be handled.
    /// - returns: Void.
    func logMessage(_ message: LogMessage)
}
