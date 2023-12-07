//
//  UIUtils.swift
//  moev
//
//  Created by Simon Chervenak on 12/7/23.
//

import Foundation
import SwiftUI

extension UIColor {
  struct Theme {
    static var listBackgroundColor = Color(hex: "ebf3fc")
    static var searchColor = Color(hex: "31f57f")
  }
}

func _hm(date: Date) -> (Int, Int) {
    let cal = Calendar.current
    var hour = cal.component(.hour, from: date)
    var minutes = cal.component(.minute, from: date)
    if minutes > 30 {
        hour += 1
        minutes = 0
    } else {
        minutes = 30
    }
    return (hour, minutes)
}

func _hm(plus: Int) -> (Int, Int) {
    let date = Date(timeIntervalSinceNow: TimeInterval(plus * 30 * 60))
    return _hm(date: date)
}

func time(plus: Int) -> String {
    let (hour, minutes) = _hm(plus: plus)
    let padh = String(repeating: "0", count: hour < 10 ? 1 : 0)
    let padm = String(repeating: "0", count: minutes < 10 ? 1 : 0)
    return "\(padh)\(hour):\(padm)\(minutes)"
}

func time(plus: Int) -> Int {
    let (h1, m1) = _hm(date: Date())
    let (h2, m2) = _hm(plus: plus)
    return (h2 - h1) * 3600 + (m2 - m1) * 60
}

func time(date: Date) -> Int {
    let (h1, m1) = _hm(date: Date())
    let (h2, m2) = _hm(date: date)
    return (h2 - h1) * 3600 + (m2 - m1) * 60
}

func time(timestamp: String?) -> Int? {
    if timestamp == nil {
        return nil
    }
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    let localDate = formatter.date(from: timestamp!)
    return localDate == nil ? nil : time(date: localDate!)
}

func xposition(for time: Int) -> Int {
    // time in seconds from now
    return time / 60 * 2  // 2 pixels per minute
}
