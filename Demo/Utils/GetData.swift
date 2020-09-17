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
}
