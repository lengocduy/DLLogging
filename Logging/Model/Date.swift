//
//  Date.swift
//  Logging
//
//  Created by Duy Le Ngoc on 7/6/20.
//  Copyright © 2020 Duy Le Ngoc. All rights reserved.
//

import Foundation

// MARK: - DateFormatted
enum DateFormatted: String {
    case iso8601 = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case logByDate = "dd-MMMM-yyyy"
    case logByTime = "hh:mm:ss.SSS"
}

// MARK: - Date Utilities
extension Date {
    static func createCurrentDateFormatterByFormat(
        _ format: DateFormatted,
        locale: Locale = Locale(identifier: "en_US_POSIX")
    ) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale =  locale
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter
    }

    func stringByFormat(_ format: DateFormatted) -> String {
        let dateFormatter = Date.createCurrentDateFormatterByFormat(format)
        return dateFormatter.string(from: self)
    }
}
