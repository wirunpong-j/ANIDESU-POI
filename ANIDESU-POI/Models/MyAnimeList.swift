//
//  MyAnimeList.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 27/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

class MyAnimeList {
    var key: String?
    var animeID: Int?
    var score: Int?
    var progress: Int?
    var note: String?
    var status: String?
    var anime: Anime?
    
    init(response: MyAnimeListResponse) {
        self.key = response.key
        self.animeID = response.anime_id
        self.score = response.score
        self.progress = response.progress
        self.note = response.note
        self.status = response.status
    }
}
