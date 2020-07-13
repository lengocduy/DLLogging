//
//  AnyLogging.swift
//  Logging
//
//  Created by Duy Le Ngoc on 7/13/20.
//  Copyright © 2020 Duy Le Ngoc. All rights reserved.
//

import Foundation

// MARK: - AnyLogging Type Erasure
public struct AnyLogging<T: Logging>: Logging {
    private let logging: T
    public init(_ logging: T) {
        self.logging = logging
    }
    
    public func receiveMessage(_ message: LogMessage) {
        logging.receiveMessage(message)
    }
    
    public func reset() {
        logging.reset()
    }
}

// MARK: - Identifiable
extension AnyLogging: Identifiable {
    var id: String {
        return "\(logging.self)"
    }
}

// MARK: - Equatable
extension AnyLogging: Equatable {
    public static func == (lhs: AnyLogging<T>, rhs: AnyLogging<T>) -> Bool {
        return lhs.id == rhs.id
    }
}
