//
//  Struct.swift
//  Demo
//
//  Created by Apple on 9/23/20.
//  Copyright © 2020 eMPI. All rights reserved.
//

import Foundation

struct EventMonth : Decodable {
    var date : Date
    var activ : String
    init(date: Date, activ: String){
        self.date = date
        self.activ = activ
    }
}
//struct EventMonth1: Codable {
//    let data: [Data]
//    init(data: [Data]) {
//        self.data = data
//    }
//}

// MARK: - Datum
struct EventDay: Codable {
    let date: Date
    let event: [Event]
    
    init(date: Date,event: [Event]) {
        self.date = date
        self.event = event
    }
}

// MARK: - Event
struct Event: Codable {
    let hours, activiti: String
    
    init(hours : String, activiti: String) {
        self.hours = hours
        self.activiti = activiti
    }
}

class EventModel: NSObject {
    
    var day: Int = 0
    var month: Int = 0
    var year: Int = 0
}
