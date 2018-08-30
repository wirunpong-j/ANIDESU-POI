//
//  MyAnimeListResponse.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 27/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

class MyAnimeListResponse: Decodable {
    var key: String?
    var anime_id: Int?
    var score: Int?
    var progress: Int?
    var note: String?
    var status: String?
    var date_time: String?
    var anime: AnimeResponse?
}
