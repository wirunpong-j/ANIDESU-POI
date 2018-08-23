//
//  AnidesuString.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 23/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

public class AnidesuString {
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
            return newArray.joined(separator: ",")
        }
        
        return NULL_TEXT
    }
    
    public static func checkNilString(str: String?) -> String {
        return str != nil ? str! : NULL_TEXT
    }
    
    public static func checkNilInt(int: Int?) -> String {
        return int != nil ? "\(int!)" : NULL_TEXT
    }
}
