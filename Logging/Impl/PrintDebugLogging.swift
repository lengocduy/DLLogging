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
    private(set) var logFormatter: LogFormatter?
    
    init(logFormatter: LogFormatter?) {
        self.logFormatter = logFormatter
    }
    
    func receiveMessage(_ message: LogMessage) {
        guard let logFormatter = logFormatter else {
            print(message.text)
            return
        }
        
        let formattedMessage = logFormatter.formatMessage(message)
        debugPrint(formattedMessage)
    }
}

// MARK: - Identifiable
extension PrintDebugLogging: Identifiable {}
