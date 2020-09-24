//
//  GetData.swift
//  Demo
//
//  Created by ELSAGA-MACOS on 9/15/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import UIKit
class GetData: NSObject {
    
    static func findEvent(value searchValue: Date, in array: [EventMonth]) -> String?
    {
        for item in array
        {
            if item.date.day == searchValue.day && item.date.month == searchValue.month && item.date.year == searchValue.year {
                return item.activ
            }
        }
        
        return nil
    }
    
    static func findEvent1(value searchValue: Date, in array: [EventDay]) -> [Event]?
    {
        var arr : [Event] = [Event]()
        let day = searchValue.day
        let month = searchValue.month
        let year = searchValue.year
       
        let filter = array.filter { (item: EventDay) -> Bool in
            return item.date.day == day && item.date.month == month && item.date.year == year
        }
//        for items in array
//        {
//            if items.date.day == searchValue.day && items.date.month == searchValue.month && items.date.year == searchValue.year {
//                for item in items.event {
//                    arr.append(Event(hours: item.hours, activiti: item.activiti))
//                }
//                return arr
//            }
//        }

        return filter.first?.event
    }
    
    static func loadJson() -> [EventMonth]? {
        if let path = Bundle.main.path(forResource: "Event", ofType: "json")
        {
             do {
                     let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                     let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                     if let result = jsonResult as? NSDictionary  {
                        if let datas = result.object(forKey: "data") as? NSArray
                        {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
                            var arrs = [EventMonth]()
                            
                            for item in datas {
                                if let item = item as? NSDictionary{
                                    if let strDate = item.object(forKey: "date"), let event = item.object(forKey: "activ")
                                    {
                                        let date = dateFormatter.date(from: strDate as! String)!
                                        arrs.append(EventMonth(date: date, activ: event as! String))
                                    }
                                }
                            }
                            
                            return arrs
                        }
                    }
                 } catch {
                      // handle error
                 }
        }
        return nil
    }
    
    static func loadJson1() -> [EventDay]? {
        if let path = Bundle.main.path(forResource: "Event", ofType: "json")
        {
             do {
                     let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                     let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                     if let result = jsonResult as? NSDictionary  {
                        if let datas = result.object(forKey: "data") as? NSArray
                        {
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
                            var arrs = [EventDay]()
                
                            for item in datas {
                                if let item = item as? NSDictionary{
                                    if let strDate = item.object(forKey: "date"), let events = item.object(forKey: "event") as? NSArray
                                    {
                                        var arrEvent = [Event]()
                                        let date = dateFormatter.date(from: strDate as! String)!
                                        for item1 in events {
                                            
                                            if let hour = (item1 as AnyObject).object(forKey: "hours") as? String, let activiti = (item1 as AnyObject).object(forKey: "activiti") as? String {
                                                let event = Event(hours: hour, activiti: activiti)
                                                arrEvent.append(event)
                                            }
                                        }
                                        arrs.append(EventDay(date:date, event: arrEvent))
                                    }
                                }
                            }
                            
                            return arrs
                        }
                    }
                 } catch {
                      // handle error
                 }
        }
        return nil
    }
}
