//
//  PrintDebugLogging.swift
//  Logging
//
//  Created by Duy Le Ngoc on 7/6/20.
//  Copyright © 2020 Duy Le Ngoc. All rights reserved.
//

import Foundation

// MARK: - PrintDebugLogging
final class PrintDebugLogging: Logging {
    private(set )var logFormatter: LogFormatter?
    
    init(logFormatter: LogFormatter?) {
        self.logFormatter = logFormatter
    }
    
    func receiveMessage(_ message: LogMessage) {
        guard let logFormatter = logFormatter else {
            printLocation(file: message.file, line: message.line)
            print(message.text)
            return
        }
        
        let formattedMessage = logFormatter.formatMessage(message)
        debugPrint(formattedMessage)
    }
}

// MARK: - Private Extension
private extension PrintDebugLogging {
    /// Logs detail location of file at a line call log method. It only uses internally
    ///
    /// - Author:
    ///   Duy Le Ngoc
    ///
    /// - parameters:
    ///     - file: The name of the file calls this method.
    ///     - line: The line of the code calls this method.
    ///
    /// - returns: Void
    func printLocation(file: String, line: Int) {
        let substrings = file.components(separatedBy: "/")
        print("### printLocation substrings = \(substrings)")
        guard substrings.count > 1 else {
            print(">>> [\(substrings.last!)]:line:\(line)")
            return
        }

        let fileName = substrings[substrings.count - 2] + substrings.last!
        print(">>> [\(fileName)]:line:\(line)")
    }
}

@available(iOS 13, *)
extension PrintDebugLogging: Identifiable {}
