//
//  AniListManager.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 17/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation
import Alamofire

public enum AnimeSeason: String {
    case Winter = "winter"
    case Spring = "spring"
    case Fall = "fall"
    case Summer = "summer"
}

class AniListManager {
    
    private enum AnilistURL {
        case authen
        case fetchAnimeBySeason
        case fetchAnimePage(animeID: Int)
        
        func getUrl() -> String {
            let BASE_URL = "https://anilist.co/api"
            switch self {
            case .authen:
                return "\(BASE_URL)/auth/access_token"
            case .fetchAnimeBySeason:
                return "\(BASE_URL)/browse/anime"
            case .fetchAnimePage(let animeID):
                return "\(BASE_URL)/anime/\(animeID)/page"
            }
        }
    }
    
    let AUTHORIZE_BODY = [
        "grant_type": "client_credentials",
        "client_id": "bbellkungdesu-vstku",
        "client_secret": "L5gVawdnzKUYaRWD3WioXZRq0rz"
    ]
    
    let API_HEADER = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]
    
    var BEARER_HEADER: [String: String] {
        get {
            return [
                "Authorization": "Bearer \(anilistToken)",
                "Content-Type": "application/json",
                "Accept": "application/json",
            ]
        }
    }
    
    var anilistToken: String {
        get {
            return UserDefaults.standard.string(forKey: "anilistToken") ?? ""
        } set {
            UserDefaults.standard.set(newValue, forKey: "anilistToken")
        }
    }
    
    func authenAnilist(onCompleted: @escaping () -> (), onFailure: @escaping (Error) -> ()) {
        Alamofire.request(AnilistURL.authen.getUrl(), method: .post, parameters: AUTHORIZE_BODY, encoding: JSONEncoding.default, headers: API_HEADER).responseJSON { (response) in
            if let error = response.result.error {
                onFailure(error)
            } else {
                let json = try! JSONDecoder().decode(AuthenResponse.self, from: response.data!)
                self.anilistToken = json.access_token!
                onCompleted()
            }
        }
    }
    
    func fetchAnimeListBySeason(season: AnimeSeason, onSuccess: @escaping ([Anime]) -> (), onFailure: @escaping (Error) -> ()) {
        let body: [String: Any] = [
            "season": season.rawValue,
            "full_page": true,
            "airing_data": true
        ]
        
        Alamofire.request(AnilistURL.fetchAnimeBySeason.getUrl(), method: .get, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if let error = response.result.error {
                onFailure(error)
            } else {
                let data = response.data
                let allAnimeResponse = try! JSONDecoder().decode([AnimeResponse].self, from: data!)
                
                var listAnime = [Anime]()
                for animeResponse in allAnimeResponse {
                    let anime = Anime(response: animeResponse)
                    listAnime.append(anime)
                }
                
                onSuccess(listAnime)
            }
        }
    }
    
    func fetchAnimePage(animeID: Int, onSuccess: @escaping (Anime) -> (), onFailure: @escaping (Error) -> ()) {
        Alamofire.request(AnilistURL.fetchAnimePage(animeID: animeID).getUrl(), method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if let error = response.result.error {
                onFailure(error)
            } else {
                let data = response.data
                let animeResponse = try! JSONDecoder().decode(AnimeResponse.self, from: data!)
                let anime = Anime(response: animeResponse)
                
                onSuccess(anime)
            }
        }
    }
}
