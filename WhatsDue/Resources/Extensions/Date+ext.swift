//
//  Date+ext.swift
//  WhatsDue
//
//  Created by Aaron O'Connor on 2/3/19.
//  Copyright © 2019 Aaron O'Connor. All rights reserved.
//

import Foundation

extension Date {
    var formatted: String {
        let df = DateFormatter()
        df.dateFormat = "MM/dd"
        df.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        return df.string(from: self as Date)
    }
}

extension Formatter {
    static let monthMedium: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL"
        return formatter
    }()
    static let hour12: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h"
        return formatter
    }()
    static let minute0x: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm"
        return formatter
    }()
    static let amPM: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "a"
        return formatter
    }()
}
