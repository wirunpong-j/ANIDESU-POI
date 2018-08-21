//
//  DateTimeFormat.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 20/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

extension Date {
    
    public func getCurrentTime() -> String {
        // 2017-11-30-06-45
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
        
        return String(format: "\(year)-%02d-%02d-%02d-%02d-%02d", month, day, hour, minutes, second)
    }
    
    public func showAnidesuDateTime(timeStr: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        let formateDate = dateFormatter.date(from: timeStr)
        dateFormatter.dateFormat = "dd MMM yyyy - HH:mm"
        
        return dateFormatter.string(from: formateDate!)
    }
}
