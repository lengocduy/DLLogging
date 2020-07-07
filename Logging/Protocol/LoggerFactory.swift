//
//  LoggerFactory.swift
//  Logging
//
//  Created by Duy Le Ngoc on 7/6/20.
//  Copyright © 2020 Duy Le Ngoc. All rights reserved.
//

import Foundation

/// LoggerFactory is designed as AbstractFactory
/// 
/// AbstractFactory defines an interface for creating families of related or dependent objects without specify concrete classes
/// A hierarchy that encapsulates: many possible "platforms", and the construction of a suite of "products".
/// The new operator considered harmful.
protocol LoggerFactory {
    static func makeConsoleLogging(logFormatter: LogFormatter?) -> Logging
    static func makeConsoleDebugLogging(logFormatter: LogFormatter?) -> Logging
    static func makeFileLogging(fileName: String, logFormatter: LogFormatter?) -> Logging
}
