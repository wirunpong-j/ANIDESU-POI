//
//  UserDataModel.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 15/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

class MyProfileModel {
    
    static var instance = MyProfileModel()
    
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
    
    var displayName: String {
        get {
            return UserDefaults.standard.string(forKey: "displayName")!
        } set {
            UserDefaults.standard.set(newValue, forKey: "displayName")
        }
    }
    
    var imageUrlProfile: String {
        get {
            return UserDefaults.standard.string(forKey: "imageUrlProfile")!
        } set {
            UserDefaults.standard.set(newValue, forKey: "imageUrlProfile")
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
