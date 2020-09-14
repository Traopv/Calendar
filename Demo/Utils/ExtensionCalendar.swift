//
//  ExtensionCalendar.swift
//  Demo
//
//  Created by Apple on 9/14/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import Foundation
extension Calendar{
    mutating func dayOfWeek(_ date: Date) -> Int {
        var dayOfWeek = self.component(.weekday, from: date) - self.firstWeekday
        self.timeZone = TimeZone(abbreviation: "GMT")!
        if dayOfWeek <= 0 {
            dayOfWeek += 7
        }

        return dayOfWeek
    }
    mutating func startOfWeek(_ date: Date) -> Date {
        return self.date(byAdding: DateComponents(day: -self.dayOfWeek(date) + 1), to: date)!
    }

    mutating func endOfWeek(_ date: Date) -> Date {
        return self.date(byAdding: DateComponents(day: 6), to: self.startOfWeek(date))!
    }
     func getAllDaysInMonth(_ month: Int, _ year : Int) -> Int{
        
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!

        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        return numDays
    }
}
