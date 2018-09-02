//
//  AnidesuString.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 23/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

public class AnidesuConverter {
    static let NULL_TEXT = "N/A"
    
    public static func getDateFuzzy(dateFuzzy: Int?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        if let dateFuzzy = dateFuzzy {
            if dateFuzzy != 0 {
                if let formateDate = dateFormatter.date(from: "\(dateFuzzy)") {
                    dateFormatter.dateFormat = "dd MMM yyyy"
                    
                    return dateFormatter.string(from: formateDate)
                }
                
                return NULL_TEXT
            }
        }

        return NULL_TEXT
    }
    
    public static func getArrayString(array: [String]?) -> String {
        if let array = array, !array.isEmpty {
            let newArray = array.filter({ $0 != "" })
            return newArray.joined(separator: ", ")
        }
        
        return NULL_TEXT
    }
    
    public static func checkNilString(str: String?) -> String {
        return str ?? NULL_TEXT
    }
    
    public static func checkNilInt(int: Int?) -> String {
        return int != 0 && int != nil ? "\(int!)" : NULL_TEXT
    }
    
    public static func getCurrentTime() -> String {
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
    
    public static func showAnidesuDateTime(timeStr: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        let formateDate = dateFormatter.date(from: timeStr)
        dateFormatter.dateFormat = "dd MMM yyyy - HH:mm"
        
        return dateFormatter.string(from: formateDate!)
    }
}
