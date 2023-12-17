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

func _hm(date: Date, clamp: Bool) -> (Int, Int) {
    let cal = Calendar.current
    var hour = cal.component(.hour, from: date)
    var minutes = cal.component(.minute, from: date)
    if clamp {
        if minutes > 30 {
//            hour += 1
            minutes = 30
        } else {
            minutes = 0
        }
    }
    return (hour, minutes)
}

func _hm(plus: Int, clamp: Bool) -> (Int, Int) {
    let date = Date(timeIntervalSinceNow: TimeInterval(plus * 30 * 60))
    return _hm(date: date, clamp: clamp)
}

func time(plus: Int) -> String {
    let (hour, minutes) = _hm(plus: plus, clamp: true)
    let padh = String(repeating: "0", count: hour < 10 ? 1 : 0)
    let padm = String(repeating: "0", count: minutes < 10 ? 1 : 0)
    return "\(padh)\(hour):\(padm)\(minutes)"
}

func time(plus: Int) -> Int {
    let (h1, m1) = _hm(date: Date(), clamp: false)
    let (h2, m2) = _hm(plus: plus, clamp: true)
    print(h1, m1, h2, m2, Date.now, plus, ((h2 - h1) * 3600 + (m2 - m1) * 60), ((h2 - h1) * 3600 + (m2 - m1) * 60) %% 2880)
    return ((h2 - h1) * 3600 + (m2 - m1) * 60) %% 86400
}

func time(date: Date) -> Int {
    let (h1, m1) = _hm(date: Date.now, clamp: false)
    let (h2, m2) = _hm(date: date, clamp: false)
    return ((h2 - h1) * 3600 + (m2 - m1) * 60) %% 86400
}

func time(timestamp: String?) -> Int? {
    if timestamp == nil {
        return nil
    }
    return time(date: date(from: timestamp!)!)
}

func xposition(for time: Int) -> Int {
    // time in seconds from now
    return time / 60 * 2  // 2 pixels per minute
}

func xposition(for step: CombinedStep) -> Int {
    return xposition(for: time(date: step.departureTime ?? Date.now)) + width(for: step) / 2
}

func width(for step: CombinedStep) -> Int {
    return xposition(for: step.totalDuration)
}

func date(from timestamp: String) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return formatter.date(from: timestamp)
}


//https://stackoverflow.com/questions/41180292/negative-number-modulo-in-swift
infix operator %%
extension Int {
    static  func %% (_ left: Int, _ right: Int) -> Int {
       let mod = left % right
       return mod >= 0 ? mod : mod + right
    }
}
