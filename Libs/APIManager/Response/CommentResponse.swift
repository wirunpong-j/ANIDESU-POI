//
//  CommentResponse.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 20/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

class CommentResponse: Decodable {
    var comment_date: String?
    var comment_message: String?
    var uid: String?
    var user: UserResponse?
    var key: String?
}
