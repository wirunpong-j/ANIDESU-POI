//
//  Router.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 29/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation
import Alamofire

public enum Router: URLRequestConvertible {
    case authAnilist
    case fetchAnimeBySeason(season: AnimeSeason)
    case fetchAnimePage(animeID: Int)
}

extension Router {
    public func asURLRequest() throws -> URLRequest {
        let url = URL(string: urlPath)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = Data()
        urlRequest.setValue("Bearer \(AniListManager.anilistToken)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return try Alamofire.JSONEncoding.default.encode(urlRequest, with: parameters)
    }
    
//    private func getHeaders(urlRequest: inout URLRequest) {
//        switch self {
//        case .authRefreshToken:
//            urlRequest.setValue("bearer " + KeychainManager().string(forKey: KeychainManager.keyRefreshToken)!, forHTTPHeaderField: "Authorization")
//        default:
//            urlRequest.setValue("bearer " + (KeychainManager().string(forKey: KeychainManager.keyAccessToken) ?? ""), forHTTPHeaderField: "Authorization")
//        }
//        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
//    }
    
    public var path: String {
        switch self {
        case .authAnilist:
            return "/auth/access_token"
        case .fetchAnimeBySeason:
            return "/browse/anime"
        case .fetchAnimePage(let animeID):
            return "/anime/\(animeID)/page"
        }
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case .authAnilist:
            return ["grant_type": "client_credentials",
                    "client_id": "bbellkungdesu-vstku",
                    "client_secret": "L5gVawdnzKUYaRWD3WioXZRq0rz"]
            
        case .fetchAnimeBySeason(let season):
            return ["season": season.rawValue,
                    "full_page": true,
                    "airing_data": true]
            
        case .fetchAnimePage:
            return nil
        }
    }
    
    public var method: Alamofire.HTTPMethod {
        switch self {
        case .authAnilist:
            return .post
        case .fetchAnimeBySeason, .fetchAnimePage:
            return .get
        }
    }
    
    public var urlPath: String {
        return "https://anilist.co/api" + path
    }
}
