//
//  BaseResponse.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 12/2/2562 BE.
//  Copyright © 2562 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

class BaseResponse: Decodable {
    var statusCode: Int?
    var error: String?
    var message: String?
    var errorMessage: String?
}

class BaseError: NSError {
    public var errorMessage: String {
        get {
            if let message = self.userInfo["errors"] as? String {
                return message
            }
            return "Error"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        let userInfo = [
            "errors": message
        ]
        super.init(domain: "Develop", code: 0, userInfo: userInfo)
    }
}
