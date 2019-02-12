//
//  AiringResponse.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 23/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

class AiringResponse: Decodable {
    var time: String?
    var countdown: Int?
    var next_episode: Int?
}
