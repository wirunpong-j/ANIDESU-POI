//
//  PostResponse.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 20/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

class PostResponse: Decodable {
    var uid: String?
    var message: String?
    var post_date: String?
    var like_count: Int?
    var user: UserResponse?
    var key: String?
    var comments: [CommentResponse]?
}
