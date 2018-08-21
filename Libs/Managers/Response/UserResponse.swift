//
//  UserResponse.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 20/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

class UserResponse: Decodable {
    var uid: String?
    var about: String?
    var display_name: String?
    var image_url_profile: String?
    var email: String?
}
