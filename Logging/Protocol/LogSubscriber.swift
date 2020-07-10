//
//  LogSubscriber.swift
//  Logging
//
//  Created by Duy Le Ngoc on 7/6/20.
//  Copyright © 2020 Duy Le Ngoc. All rights reserved.
//

import Foundation

// MARK: - LogSubscriber Observer
public protocol LogSubscriber {
    /// Receive a new message an instance of `LogMessage`.
    /// Normally, This function was invoked by an Observable (Subject).
    ///
    /// - parameter message: An instance LogMessage need to be handled.
    /// - returns: Void.
    func receiveMessage(_ message: LogMessage)
}
