//
//  PrintLogging.swift
//  Logging
//
//  Created by Duy Le Ngoc on 7/6/20.
//  Copyright © 2020 Duy Le Ngoc. All rights reserved.
//

import Foundation

final class PrintLogging: BaseLogging {
    override func receiveMessage(_ message: LogMessage) {
        guard let logFormatter = logFormatter else {
            print(message.text)
            return
        }
        
        let formattedMessage = logFormatter.formatMessage(message)
        print(formattedMessage)
    }
}
