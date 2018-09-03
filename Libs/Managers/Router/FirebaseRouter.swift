//
//  FirebaseRouter.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 30/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation

public enum FirebaseRouter {
    case setUpProfile(uid: String, displayName: String, email: String, imageURL: String)
    case fetchUserData(uid: String)
    case createPost(message: String)
    case fetchAllPost
    case fetchAllComment(postKey: String)
    case comment(postKey: String, uid: String, message: String)
    case addMyAnimeList(animeID: Int, note: String, status: String, progress: Int, score: Int)
    case fetchMyAnimeList(animeID: Int)
    case fetchAllMyAnimeList
    case addReview(animeID: Int, desc: String, rating: Double, reviewDate: String, uid: String)
    case fetchAllReview
    case fetchReviewPage(animeID: Int, key: String)
    
    public var path: String {
        switch self {
        case .setUpProfile(let params):
            return "anidesu/users/\(params.uid)/profile"
        case .fetchUserData(let uid):
            return "anidesu/users/\(uid)/profile"
        case .addMyAnimeList(let params):
            return "anidesu/users/\(MyProfileModel.instance.uid)/list_anime/\(params.animeID)"
        case .fetchMyAnimeList(let animeID):
            return "anidesu/users/\(MyProfileModel.instance.uid)/list_anime/\(animeID)"
        case .fetchAllMyAnimeList:
            return "anidesu/users/\(MyProfileModel.instance.uid)/list_anime"
        case .createPost, .fetchAllPost:
            return "anidesu/posts"
        case .fetchAllComment(let postKey):
            return "anidesu/posts/\(postKey)/comment"
        case .comment(let params):
            return "anidesu/posts/\(params.postKey)/comment"
        case .addReview, .fetchAllReview:
            return "anidesu/reviews/"
        case .fetchReviewPage(let params):
            return "anidesu/reviews/\(params.key)"
        }
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case .setUpProfile(let uid, let displayName, let email, let imageURL):
            return ["uid": uid,
                    "display_name": displayName,
                    "email": email,
                    "image_url_profile": imageURL,
                    "about": "Welcome To AniDesu."]
            
        case .addMyAnimeList(let params):
            return ["anime_id": params.animeID,
                    "note": params.note,
                    "status": params.status,
                    "progress": params.progress,
                    "score": params.score,
                    "date_time": AnidesuConverter.getCurrentTime()]
        
        case .createPost(let message):
            return ["uid": MyProfileModel.instance.uid,
                    "message": message,
                    "post_date": AnidesuConverter.getCurrentTime(),
                    "like_count": 0]
            
        case .comment(let params):
            return [ "uid": params.uid,
                     "comment_message": params.message,
                     "comment_date": AnidesuConverter.getCurrentTime()]
            
        case .addReview(let params):
            return ["anime_id": params.animeID,
                    "desc": params.desc,
                    "rating": params.rating,
                    "review_date": params.reviewDate,
                    "uid": params.uid]
        default:
            return nil
        }
    }
}
