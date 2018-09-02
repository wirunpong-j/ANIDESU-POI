//
//  Airing.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 23/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

class Airing {
    var time: String
    var countdown: Int
    var nextEP: Int
    
    init() {
        self.time = AnidesuConverter.NULL_TEXT
        self.countdown = 0
        self.nextEP = 0
    }
    
    init(response: AiringResponse) {
        self.time = response.time ?? AnidesuConverter.NULL_TEXT
        self.countdown = response.countdown ?? 0
        self.nextEP = response.next_episode ?? 0
    }
    
    public func getNextEpisodeTime() -> String {
        return self.nextEP != 0 ? "EP \(self.nextEP) Airing in \(self.countdown / 3600)h" : AnidesuConverter.NULL_TEXT
    }
}
