//
//  Model.swift
//  Weather3rd
//
//  Created by Cuong15tr on 12/17/17.
//  Copyright © 2017 Cuong15tr. All rights reserved.
//

import Foundation

typealias JSON = Dictionary<AnyHashable, Any>

class Weather {
    var hourly : [Hour] = []
    var daily : [Day] = []
    var current: Currently
    init?(dictionary: JSON) {
        guard let hourly = dictionary["hourly"] as? JSON else {return nil}
        guard let hours = hourly["data"] as? [JSON] else {return nil}
        for hour in hours {
            guard let result = Hour(dictionary: hour) else {return nil}
            self.hourly.append(result)
        }
        guard let dayly = dictionary["daily"] as? JSON else {return nil}
        guard let days = dayly["data"] as? [JSON] else {return nil}
        for day in days{
            guard let result = Day(dictionary: day) else {return nil}
            self.daily.append(result)
        }
        guard let currentJson = dictionary["currently"] as? JSON else {return nil}
        guard let current = Currently(dictionary: currentJson) else {return nil}
        
        self.current = current
    }
}
class Currently {
    var time: TimeInterval
    var summary: String
    var icon: String
    var temperature: Double
    
    init?(dictionary: JSON ) {
        guard let time = dictionary["time"] as? TimeInterval else {return nil}
        guard let summary = dictionary["summary"] as? String else {return nil}
        guard let icon = dictionary["icon"] as? String else {return nil}
        guard let temperature = dictionary["temperature"] as? Double else {return nil}
        
        self.time = time
        self.summary = summary
        self.icon = icon
        self.temperature = temperature
    }
}
class Hour {
    var time: TimeInterval
    var summary: String
    var icon: String
    var temperature: Double
    init?(dictionary: JSON ) {
        guard let time = dictionary["time"] as? TimeInterval else {return nil}
        guard let summary = dictionary["summary"] as? String else {return nil}
        guard let icon = dictionary["icon"] as? String else {return nil}
        guard let temperature = dictionary["temperature"] as? Double else {return nil}
        
        self.time = time
        self.summary = summary
        self.icon = icon
        self.temperature = temperature
    }
}
class Day {
    var time: TimeInterval
    var summary: String
    var icon: String
    var temp_max: Double
    var temp_min: Double
    
    init?(dictionary: JSON ) {
        guard let time = dictionary["time"] as? TimeInterval else {return nil}
        guard let summary = dictionary["summary"] as? String else {return nil}
        guard let icon = dictionary["icon"] as? String else {return nil}
        guard let temp_max = dictionary["temperatureMax"] as? Double else {return nil}
        guard let temp_min = dictionary["temperatureMin"] as? Double else {return nil}
        
        self.time = time
        self.summary = summary
        self.icon = icon
        self.temp_max = temp_max
        self.temp_min = temp_min
    }
    
}
