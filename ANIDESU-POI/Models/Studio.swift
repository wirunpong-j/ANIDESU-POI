//
//  Studio.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 23/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

class Studio {
    var id: Int?
    var studioName: String?
    var studioWiki: String?
    
    init(response: StudioResponse) {
        self.id = response.id
        self.studioName = response.studio_name == nil ? AnidesuString.NULL_TEXT : response.studio_name
        self.studioWiki = response.studio_wiki == nil ? AnidesuString.NULL_TEXT : response.studio_wiki
    }
}
