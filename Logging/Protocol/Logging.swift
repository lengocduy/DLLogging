//
//  Logging.swift
//  Logging
//
//  Created by Duy Le Ngoc on 7/1/20.
//  Copyright © 2020 Duy Le Ngoc. All rights reserved.
//

import Foundation

// MARK: - Identifiable
@available(iOS, introduced: 11.12)
protocol Identifiable {
    /// A type representing the stable identity of the entity associated with `self`.
    associatedtype ID: Hashable

    /// The stable identity of the entity associated with `self`.
    var id: Self.ID { get }
}

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
