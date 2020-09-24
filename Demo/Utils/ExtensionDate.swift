//
//  ExtensionDate.swift
//  Demo
//
//  Created by Apple on 9/14/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import Foundation
extension Date {
    func dayOfWeek() -> Int {
        let timeZone = TimeZone(abbreviation: "GMT")
        let component =  Calendar.current.dateComponents(in: timeZone!, from: self)
        return (component.weekday ?? -1) - 1
    }
    
    // ngày đầu tháng của tháng hiện tại
    func startOfMonth() -> Date {
        
        var components = Calendar.current.dateComponents([.year,.month], from: self)
        components.day = 2
        let firstDateOfMonth: Date = Calendar.current.date(from: components)!
        return firstDateOfMonth
    }
    
    // ngày cuối tháng của tháng hiện tại
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    // lấy ra ngày kế tiếp theo số ngày truyền vào của tháng hiện tại
    func nextDate(_ day : Int) -> Date {
        let nextDate = Calendar.current.date(byAdding: .day, value: day, to: self)
        return nextDate ?? Date()
    }
    
    // lấy ra ngày trước đó theo số ngày truyền vào của tháng hiện tại
    func previousDate(_ day: Int) -> Date {
        let previousDate = Calendar.current.date(byAdding: .day, value: -day, to: self)
        return previousDate ?? Date()
    }
    
    // lấy ra tháng kế tiếp theo số tháng truyền vào của tháng hiện tại
    func addMonths(numberOfMonths: Int) -> Date {
        let endDate = Calendar.current.date(byAdding: .month, value: numberOfMonths, to: self)
        return endDate ?? Date()
    }
    func addWeeks(numberOfWeeks: Int) -> Date {
        let endDate = Calendar.current.date(byAdding: .weekOfMonth, value: numberOfWeeks, to: self)
        return endDate ?? Date()
    }
    
    // lấy ra tháng các tháng trước theo số tháng truyền vào của tháng hiện tại
    func getPreviousMonths(numberOfMonths: Int) -> Date {
        let endDate = Calendar.current.date(byAdding: .month, value: -numberOfMonths, to: self)
        return endDate ?? Date()
    }
    
    // lấy ra năm trước
    var getPreviousYear: Date {
       return Calendar.current.date(byAdding: .year, value: -1, to: self)!
    }
    
    // lấy ra tháng kế tiếp
    var getNextMonthDate: Date {
       return Calendar.current.date(byAdding: .month, value: 1, to: self)!
    }
    
    // lấy ra tháng trước
    var getPreviousMonthDate: Date {
       return Calendar.current.date(byAdding: .month, value: -1, to: self)!
    }
    
    // ngày đầu tháng và cuối tháng của tháng kế tiếp
    var startDateOfNextMonth: Date {
       return getNextMonthDate.startOfMonth()
    }

    var endOfNextMonth: Date {
       return getNextMonthDate.endOfMonth()
    }

    // ngày đầu tháng và cuối tháng của tháng trước
    var startDateOfPreviousMonth: Date {
       return getPreviousMonthDate.startOfMonth()
    }

    var endOfPreviousMonth: Date {
       return getPreviousMonthDate.endOfMonth()
    }
    // create date from day,month,year
    
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
