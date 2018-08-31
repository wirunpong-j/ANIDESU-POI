//
//  FirestoreRouter.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 31/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation
import FirebaseFirestore

public enum FirestoreRouter {
    case fetchUserData(uid: String)
    case setUpProfile(uid: String, displayName: String, email: String, imageURL: String)
    case fetchAllPost
    case createPost(message: String)
    case fetchAllComment(postKey: String)
    case addComment(postKey: String, message: String)
    case fetchAllMyAnimeList
    case fetchMyAnimeList(animeID: Int)
    case updateMyAnimeList(animeID: Int, note: String, status: String, progress: Int, score: Int)
    case removeMyAnimeList(animeID: Int)
    case fetchAllReview
}

extension FirestoreRouter {
    
    public var path: String {
        switch self {
        case .fetchUserData(let uid):
            return "users/\(uid)"
            
        case .setUpProfile(let params):
            return "users/\(params.uid)"
            
        case .createPost, .fetchAllPost:
            return "posts"
        
        case .fetchAllComment(let postKey):
            return "posts/\(postKey)/comment"
        
        case .addComment(let params):
            return "posts/\(params.postKey)/comment"
            
        case .fetchMyAnimeList(let animeID):
            return "users/\(UserDataModel.instance.uid)/list_anime/\(animeID)"
            
        case .fetchAllMyAnimeList:
            return "users/\(UserDataModel.instance.uid)/list_anime"
            
        case .updateMyAnimeList(let params):
            return "users/\(UserDataModel.instance.uid)/list_anime/\(params.animeID)"
            
        case .removeMyAnimeList(let animeID):
            return "users/\(UserDataModel.instance.uid)/list_anime/\(animeID)"
            
        case .fetchAllReview:
            return "reviews"
        }
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case .setUpProfile(let params):
            return ["uid": params.uid,
                    "display_name": params.displayName,
                    "email": params.email,
                    "image_url_profile": params.imageURL,
                    "about": "Welcome To AniDesu."]
            
        case .createPost(let message):
            return ["uid": UserDataModel.instance.uid,
                    "message": message,
                    "post_date": AnidesuConverter.getCurrentTime(),
                    "like_count": 0]
        
        case .addComment(let params):
            return [ "uid": UserDataModel.instance.uid,
                     "comment_message": params.message,
                     "comment_date": AnidesuConverter.getCurrentTime()]
        
        case .updateMyAnimeList(let params):
            return ["anime_id": params.animeID,
                    "note": params.note,
                    "status": params.status,
                    "progress": params.progress,
                    "score": params.score,
                    "date_time": AnidesuConverter.getCurrentTime()]
            
        default:
            return nil
        }
    }
}
