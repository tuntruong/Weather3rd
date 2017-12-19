//
//  Extensen.swift
//  Weather3rd
//
//  Created by Cuong15tr on 12/17/17.
//  Copyright © 2017 Cuong15tr. All rights reserved.
//

import Foundation
extension TimeInterval {
    func gethour() -> String {
        let hour = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        dateFormatter.locale = Locale(identifier: "EN" )
        return dateFormatter.string(from: hour )
    }
    
    func dayWeek() -> String {
        let getDay = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale(identifier: "EN" )
        return dateFormatter.string(from: getDay )
        
    }
}
