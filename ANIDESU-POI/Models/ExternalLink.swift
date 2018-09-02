//
//  ExternalLink.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 23/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

class ExternalLink {
    var id: Int
    var url: String
    var site: String
    
    init(response: ExternalLinkResponse) {
        self.id = response.id ?? 0
        self.url = response.url ?? ""
        self.site = response.site ?? ""
    }
}
