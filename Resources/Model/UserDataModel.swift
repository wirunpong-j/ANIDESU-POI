//
//  UserDataModel.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 15/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

class UserDataModel: Decodable {
    
    static var instance = UserDataModel()
    
    var uid: String {
        get {
            return UserDefaults.standard.string(forKey: "uid")!
        } set {
            UserDefaults.standard.set(newValue, forKey: "uid")
        }
    }
    
    var about: String {
        get {
            return UserDefaults.standard.string(forKey: "about")!
        } set {
            UserDefaults.standard.set(newValue, forKey: "about")
        }
    }
    
    var display_name: String {
        get {
            return UserDefaults.standard.string(forKey: "display_name")!
        } set {
            UserDefaults.standard.set(newValue, forKey: "display_name")
        }
    }
    
    var image_url_profile: String {
        get {
            return UserDefaults.standard.string(forKey: "image_url_profile")!
        } set {
            UserDefaults.standard.set(newValue, forKey: "image_url_profile")
        }
    }
    
    var email: String {
        get {
            return UserDefaults.standard.string(forKey: "email")!
        } set {
            UserDefaults.standard.set(newValue, forKey: "email")
        }
    }
}
