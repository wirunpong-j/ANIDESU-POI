//
//  MyAnimeList.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 27/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

class MyAnimeList {
    var animeID: Int
    var score: Int
    var progress: Int
    var note: String
    var status: String
    var dateTime: String
    var anime: Anime?
    
    init(animeID: Int, form: [String: Any]) {
        self.animeID = animeID
        self.note = form["notes"] as? String ?? ""
        self.status = form["status"] as? String ?? ""
        self.progress = form["progress"] as? Int ?? 0
        self.score = form["score"] as? Int ?? 0
        self.dateTime = ""
    }
    
    init(response: MyAnimeListResponse) {
        self.animeID = response.anime_id ?? 0
        self.score = response.score ?? 0
        self.progress = response.progress ?? 0
        self.note = response.note ?? ""
        self.status = response.status ?? ""
        self.dateTime = response.date_time ?? ""
    }
}
