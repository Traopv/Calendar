//
//  Utils.swift
//  Demo
//
//  Created by ELSAGA-MACOS on 9/11/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import UIKit

class Utils: NSObject {
    static func getAllDayWeek(date : Date,month: Int,year: Int) ->[Int]{
        var allDay : [Int] = [Int]()
        var calendar = Calendar.current
        let startWeek = calendar.startOfWeek(date)
        let endWeek = Int(startWeek.toString(dateFormat: "dd"))! + 7
        let numberDays : Int
        let prevNumberDays : Int
        var preMonth : Int
        
        var newMonth : Int
        
        if month == 1 {
            preMonth = 12
            numberDays = calendar.getAllDaysInMonth(preMonth, year - 1)
        }
        else if month == 12 {
            newMonth = 1
            numberDays = calendar.getAllDaysInMonth(newMonth, year + 1)
        }
        else{
            numberDays = calendar.getAllDaysInMonth(month, year)
        }
        var startDay = 1
        
        for i in Int(startWeek.toString(dateFormat: "dd"))! ... endWeek{
            
            if i > numberDays {
                allDay.insert(startDay, at: allDay.endIndex)
                startDay += 1
            }
            else{
                allDay.append(i)
            }
        }
        return allDay
    }
    static func getDayInMonth(month: Int, year: Int) -> [Date]{
        var allDaysInMonth : [Date] = [Date]()
            let date = Date()
            let calendar = Calendar.current
            // load dữ liệu tháng hiện tại vào mảng
            let numberDays = calendar.getAllDaysInMonth(month, year)
            for day in 1 ... numberDays {
                let date1 = dateFrom(year: year, month: month, day: day)
                allDaysInMonth.append(date1)
            }
            //load dữ liệu tháng trước đó vào mảng
            let firstMonth = allDaysInMonth[0]
            let dayInWeek = firstMonth.dayOfWeek()
            
            // nếu tháng hiện tại là tháng 1
            if date.month == 1 {
                
                let preMonth = 12
                let preYear = year - 1
                var numberDaysPre = calendar.getAllDaysInMonth(preMonth, preYear)
                
                if dayInWeek == 0 {
                    if dayInWeek - 1 == 0{
                        for _ in 1 ... 6{
                            let datePre = dateFrom(year: preYear, month: preMonth, day: numberDaysPre)
                            allDaysInMonth.insert(datePre, at: 0)
                            numberDaysPre -= 1
                        }
                    }
                }
                    // dayInWeek là vào t2
                else if dayInWeek == 1{
                }
                else {
                    for _ in 1 ..< dayInWeek{
                        let datePre = dateFrom(year: preYear, month: preMonth, day: numberDaysPre)
                        allDaysInMonth.insert(datePre, at: 0)
                        numberDaysPre -= 1
                    }
                }
            }
            else {
                let preMonth = month - 1
                let preYear = year
                var numberDaysPre = calendar.getAllDaysInMonth(preMonth, year)
                if dayInWeek == 0 {
                    if dayInWeek - 1 == 0{
                        for _ in 1 ... 6{
                            let datePre = dateFrom(year: preYear, month: preMonth, day: numberDaysPre)
                            allDaysInMonth.insert(datePre, at: 0)
                            numberDaysPre -= 1
                        }
                    }
                }
                    // dayInWeek là vào t2
                else if dayInWeek == 1{
                }
                else {
                    for _ in 1 ..< dayInWeek{
                        let datePre = dateFrom(year: preYear, month: preMonth, day: numberDaysPre)
                        allDaysInMonth.insert(datePre, at: 0)
                        numberDaysPre -= 1
                    }
                }
            }
            return allDaysInMonth
        }
    static func getAllDateOfMonth(month: Int, year: Int) -> [Date]{
        var allDaysInMonth : [Date] = [Date]()
        let date = Date()
        let calendar = Calendar.current
        // load dữ liệu tháng hiện tại vào mảng
        let numberDays = calendar.getAllDaysInMonth(month, year)
        for day in 1 ... numberDays {
            let date1 = dateFrom(year: year, month: month, day: day)
            allDaysInMonth.append(date1)
        }
        //load dữ liệu tháng trước đó vào mảng
        let firstMonth = allDaysInMonth[0]
        let dayInWeek = firstMonth.dayOfWeek()
        
        // nếu tháng hiện tại là tháng 1
        if date.month == 1 {
            
            let preMonth = 12
            let preYear = year - 1
            var numberDaysPre = calendar.getAllDaysInMonth(preMonth, preYear)
            
            if dayInWeek == 0 {
                if dayInWeek - 1 == 0{
                    for _ in 1 ... 6{
                        let datePre = dateFrom(year: preYear, month: preMonth, day: numberDaysPre)
                        allDaysInMonth.insert(datePre, at: 0)
                        numberDaysPre -= 1
                    }
                }
            }
                // dayInWeek là vào t2
            else if dayInWeek == 1{
            }
            else {
                for _ in 1 ..< dayInWeek{
                    let datePre = dateFrom(year: preYear, month: preMonth, day: numberDaysPre)
                    allDaysInMonth.insert(datePre, at: 0)
                    numberDaysPre -= 1
                }
            }
        }
        else {
            let preMonth = month - 1
            let preYear = year
            var numberDaysPre = calendar.getAllDaysInMonth(preMonth, year)
            if dayInWeek == 0 {
                if dayInWeek - 1 == 0{
                    for _ in 1 ... 6{
                        let datePre = dateFrom(year: preYear, month: preMonth, day: numberDaysPre)
                        allDaysInMonth.insert(datePre, at: 0)
                        numberDaysPre -= 1
                    }
                }
            }
                // dayInWeek là vào t2
            else if dayInWeek == 1{
            }
            else {
                for _ in 1 ..< dayInWeek{
                    let datePre = dateFrom(year: preYear, month: preMonth, day: numberDaysPre)
                    allDaysInMonth.insert(datePre, at: 0)
                    numberDaysPre -= 1
                }
            }
        }
        if allDaysInMonth.count < 42 {
            if month == 12 {
                let newMonth = month + 1
                let newYear = year + 1
                for i in 1 ... (42 - allDaysInMonth.count){
                    let dateNew = dateFrom(year: newYear, month: newMonth, day: i)
                    allDaysInMonth.insert(dateNew, at: allDaysInMonth.endIndex)
                }
            }
            else{
                let newMonth = month + 1
                let newYear = year
                for i in 1 ... (42 - allDaysInMonth.count){
                    let dateNew = dateFrom(year: newYear, month: newMonth, day: i)
                    allDaysInMonth.insert(dateNew, at: allDaysInMonth.endIndex)
                }
            }
        }
        return allDaysInMonth
    }
    
    static func dateFrom(year: Int, month: Int, day: Int) -> Date {
        let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        gregorianCalendar.timeZone = TimeZone(abbreviation: "GMT")!

        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day

        let date = gregorianCalendar.date(from: dateComponents)!
        return date
    }
}
