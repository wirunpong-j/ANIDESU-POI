//
//  ReviewResponse.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 30/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

class ReviewResponse: Decodable {
    var key: String?
    var anime_id: Int?
    var title: String?
    var desc: String?
    var rating: Double?
    var review_date: String?
    var uid: String?
    var user: UserResponse?
    var anime: AnimeResponse?
}
