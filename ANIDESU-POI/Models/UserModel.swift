//
//  UserModel.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 3/9/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

class UserModel {
    var uid: String
    var password: String
    var about: String
    var displayName: String
    var imageUrlProfile: String
    var email: String
    
    
    init(displayName: String, email: String, password: String) {
        self.uid = ""
        self.password = password
        self.about = ""
        self.displayName = displayName
        self.imageUrlProfile = ""
        self.email = email
    }
    
    init(response: UserResponse) {
        self.uid = response.uid ?? ""
        self.password = ""
        self.about = response.about ?? ""
        self.displayName = response.display_name ?? ""
        self.imageUrlProfile = response.image_url_profile ?? ""
        self.email = response.email ?? ""
    }
}
