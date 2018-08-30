//
//  MyAnimeList.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 27/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

class MyAnimeList {
    var animeID: Int?
    var score: Int?
    var progress: Int?
    var note: String?
    var status: String?
    var dateTime: String?
    var anime: Anime?
    
    init() {}
    
    init(response: MyAnimeListResponse) {
        self.animeID = response.anime_id
        self.score = response.score
        self.progress = response.progress
        self.note = response.note
        self.status = response.status
        self.dateTime = response.date_time
    }
    
    init(animeID: Int, note: String, status: String, progress: Int, score: Int) {
        self.animeID = animeID
        self.note = note
        self.status = status
        self.progress = progress
        self.score = score
    }
}
