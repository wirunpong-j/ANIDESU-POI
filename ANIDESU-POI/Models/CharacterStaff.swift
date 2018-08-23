//
//  CharacterStaff.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 23/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

class CharacterStaff {
    var id: Int?
    var firstName: String?
    var lastName: String?
    var imageUrlLarge: String?
    var imageUrlMed: String?
    var role: String?
    
    init(response: CharacterStaffResponse) {
        self.id = response.id
        self.firstName = response.name_first
        self.lastName = response.name_last
        self.imageUrlLarge = response.image_url_lge
        self.imageUrlMed = response.image_url_med
        self.role = response.role
    }
}
