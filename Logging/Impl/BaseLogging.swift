//
//  BaseLogging.swift
//  Logging
//
//  Created by Duy Le Ngoc on 7/13/20.
//  Copyright © 2020 Duy Le Ngoc. All rights reserved.
//

import Foundation

// MARK: Logging
open class BaseLogging: Logging {
    public private(set) var logFormatter: LogFormatter?
    
    public init(logFormatter: LogFormatter?) {
        self.logFormatter = logFormatter
    }
    
    open func receiveMessage(_ message: LogMessage) {
        fatalError("All subsclasses must implement this method")
    }
    
    open func reset() {}
}

// MARK: Equatable
extension BaseLogging: Equatable {
    public static func == (lhs: BaseLogging, rhs: BaseLogging) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: Identifiable
extension BaseLogging: Identifiable {}
