//
//  LoggerFactoryImpl.swift
//  Logging
//
//  Created by Duy Le Ngoc on 7/6/20.
//  Copyright © 2020 Duy Le Ngoc. All rights reserved.
//

import Foundation

// MARK: - LoggerFactoryImpl
enum LoggerFactoryImpl: LoggerFactory {
    static func makeConsoleLogging(logFormatter: LogFormatter? = nil) -> Logging {
        return PrintLogging(logFormatter: logFormatter)
    }
    
    static func makeConsoleDebugLogging(logFormatter: LogFormatter?) -> Logging {
        return PrintDebugLogging(logFormatter: logFormatter)
    }
    
    static func makeFileLogging(fileName: String, logFormatter: LogFormatter?) -> Logging {
        let filePath = getPathFileName(fileName)
        return FileLogging(path: filePath, logFormatter: logFormatter)
    }
}

// MARK: - Private Extension
private extension LoggerFactory {
    static func getPathFileName(_ fileName: String) -> String {
        return FileManager
            .default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(fileName)
            .path
    }
}
