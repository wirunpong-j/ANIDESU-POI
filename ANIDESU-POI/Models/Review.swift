//
//  Review.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 30/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

class Review {
    var key: String?
    var animeID: Int?
    var desc: String?
    var rating: Double?
    var reviewDate: String?
    var uid: String?
    var user: UserResponse?
    var anime: Anime?
    
    init() {}
    
    init(response: ReviewResponse) {
        self.key = response.key
        self.animeID = response.anime_id
        self.desc = response.desc
        self.rating = response.rating
        self.reviewDate = response.review_date
        self.uid = response.uid
    }
}
