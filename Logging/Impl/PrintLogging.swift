//
//  PrintLogging.swift
//  Logging
//
//  Created by Duy Le Ngoc on 7/6/20.
//  Copyright © 2020 Duy Le Ngoc. All rights reserved.
//

import Foundation

final class PrintLogging: Logging {
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
        print(formattedMessage)
    }
}

// MARK: - Identifiable
extension PrintLogging: Identifiable {}
