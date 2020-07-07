//
//  Logging.swift
//  Logging
//
//  Created by Duy Le Ngoc on 7/1/20.
//  Copyright © 2020 Duy Le Ngoc. All rights reserved.
//

import Foundation

/// Any object that conforms to this protocol may log messages
// MARK: - Logging
protocol Logging: LogSubscriber {
    /// Decorate (delegate) allow client customize format message.
    var logFormatter: LogFormatter? { get }
    
    /// Reset all messages to the initial state.
    /// Normally, It clears console log, file's content.
    ///
    /// - returns: Void.
    func reset()
}

// MARK: - Default Implementation
extension Logging {
    var logFormatter: LogFormatter? {
        return nil
    }
    
    func reset() {}
}

extension Identifiable where Self: AnyObject {
    var id: ObjectIdentifier {
        return ObjectIdentifier(self)
    }
}
