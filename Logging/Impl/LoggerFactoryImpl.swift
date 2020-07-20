//
//  LoggerFactoryImpl.swift
//  Logging
//
//  Created by Duy Le Ngoc on 7/6/20.
//  Copyright © 2020 Duy Le Ngoc. All rights reserved.
//

import Foundation

// MARK: - LoggerFactoryImpl
public struct LoggerFactoryImpl: LoggerFactory {
    public static func makeConsoleLogging(logFormatter: LogFormatter? = nil) -> BaseLogging {
        return PrintLogging(logFormatter: logFormatter)
    }
    
    public static func makeConsoleDebugLogging(logFormatter: LogFormatter? = nil) -> BaseLogging {
        return PrintDebugLogging(logFormatter: logFormatter)
    }
    
    public static func makeFileLogging(logFormatter: LogFormatter? = nil, delegate: FileLoggingDelegate? = nil) -> BaseLogging {
        return FileLogging(logFormatter: logFormatter, delegate: delegate)
    }
}
