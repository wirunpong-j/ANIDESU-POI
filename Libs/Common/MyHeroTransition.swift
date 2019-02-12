//
//  MyHeroTransition.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 7/9/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

public enum MyHeroTransition {
    case animeDetailCoverImage(row: Int)
    case reviewBannerImage(row: Int)
    case reviewerImage(row: Int)
    
    public var id: String {
        switch self {
        case .animeDetailCoverImage(let row):
            return "animeDetailCoverImage\(row)"
        case .reviewBannerImage(let row):
            return "reviewBannerImage\(row)"
        case .reviewerImage(let row):
            return "reviewerImage\(row)"
        }
    }
}
