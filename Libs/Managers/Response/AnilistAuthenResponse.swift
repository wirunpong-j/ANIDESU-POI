//
//  AuthenResponse.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 17/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

class AnilistAuthenResponse: Decodable {
    
//    {
//    "access_token": "0Hw7GoRLK10Jr7Wh15lWDUaUMq8ye1WO6sc4BGX1",
//    "token_type": "Bearer",
//    "expires_in": 3600,
//    "expires": 1534501395
//    }
    
    var access_token: String?
    var token_type: String?
    var expires_in: Int?
    var expires: Double?
}
