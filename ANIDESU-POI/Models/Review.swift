//
//  Review.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 30/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

class Review {
    var key: String
    var animeID: Int
    var title: String
    var desc: String
    var rating: Double
    var reviewDate: String
    var uid: String
    var user: UserResponse?
    var anime: Anime?
    
    init(animeID: Int, title: String, desc: String, rating: Double, reviewDate: String, uid: String) {
        self.key = ""
        self.animeID = animeID
        self.title = title
        self.desc = desc
        self.rating = rating
        self.reviewDate = reviewDate
        self.uid = uid
    }
    
    init(response: ReviewResponse) {
        self.key = response.key ?? ""
        self.animeID = response.anime_id ?? 0
        self.title = response.title ?? ""
        self.desc = response.desc ?? ""
        self.rating = response.rating ?? 0
        self.reviewDate = response.review_date ?? ""
        self.uid = response.uid ?? ""
    }
}
