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
    
    public static func makeFileLogging(fileName: String, logFormatter: LogFormatter? = nil) -> BaseLogging {
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
