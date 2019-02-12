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
    public static var anilistToken: String {
        get {
            return UserDefaults.standard.string(forKey: "anilistToken") ?? ""
        } set {
            UserDefaults.standard.set(newValue, forKey: "anilistToken")
        }
    }
    
    func authenAnilist(onCompleted: @escaping () -> (), onFailure: @escaping (Error) -> ()) {
        let router = Router.authAnilist
        APIManager.request(withRouter: router, responseType: AnilistAuthenResponse.self, completion: { (response) in
            AniListManager.anilistToken = response.access_token!
            onCompleted()
        }) { (error) in
            onFailure(error)
        }
    }
    
    func fetchAnimeListBySeason(season: AnimeSeason, onSuccess: @escaping ([Anime]) -> (), onFailure: @escaping (Error) -> ()) {
        let router = Router.fetchAnimeBySeason(season: season)
        APIManager.request(withRouter: router, responseType: [AnimeResponse].self, completion: { (allResponse) in
            var listAnime = [Anime]()
            
            for response in allResponse {
                let anime = Anime(response: response)
                listAnime.append(anime)
            }
            
            onSuccess(listAnime)
        }) { (error) in
            onFailure(error)
        }
    }
    
    func fetchAnimePage(animeID: Int, onSuccess: @escaping (Anime) -> (), onFailure: @escaping (Error) -> ()) {
        let router = Router.fetchAnimePage(animeID: animeID)
        APIManager.request(withRouter: router, responseType: AnimeResponse.self, completion: { (response) in
            let anime = Anime(response: response)
            onSuccess(anime)
        }) { (error) in
            onFailure(error)
        }
    }
}
