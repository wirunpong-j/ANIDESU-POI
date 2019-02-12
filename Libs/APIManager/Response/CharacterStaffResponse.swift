//
//  CharacterStaffResponse.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 23/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

class CharacterStaffResponse: Decodable {
    var id: Int?
    var name_first: String?
    var name_last: String?
    var image_url_lge: String?
    var image_url_med: String?
    var role: String?
}
