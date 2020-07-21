//
//  FileLoggingDelegate.swift
//  Logging
//
//  Created by Duy Le Ngoc on 7/20/20.
//  Copyright © 2020 Duy Le Ngoc. All rights reserved.
//

import Foundation

// MARK: - FileLoggingDelegate
public protocol FileLoggingDelegate: AnyObject {
    var logFileName: String { get }
    var flushInterval: TimeInterval { get }
    
    /// Notify new data to client handling
    ///
    /// - parameters:
    ///     - data: new Data coming from the Log.
    ///     - on: formattedDate "dd-MMMM-yyyy".
    ///     - at: formattedTime "hh:mm:ss.SSS".
    ///
    /// - returns: Void.
    func receiveData(_ data: Data?, on formattedDate: String, at timeFormatted: String)
}

public extension FileLoggingDelegate {
    var logFileName: String {
        return "appLog"
    }
    
    var flushInterval: TimeInterval {
        return 60.0
    }
}
