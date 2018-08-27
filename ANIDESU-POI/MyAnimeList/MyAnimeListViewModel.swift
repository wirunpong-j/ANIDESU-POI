//
//  MyAnimeListViewModel.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 27/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class MyAnimeListViewModel {
    
    var firebaseManager = FirebaseManager()
    var anilistManager = AniListManager()
   
    let errorRelay: PublishRelay<String> = PublishRelay()
    
    public func fetchAllMyAnimeList(status: MyAnimeListStatus, completion: @escaping ([MyAnimeList]) -> ()) {
        self.firebaseManager.fetchMyAnimeList(status: status, uid: UserDataModel.instance.uid, onSuccess: { (allResponse) in
            var myAnimeList = [MyAnimeList]()
            
            if allResponse.isEmpty {
                completion(myAnimeList)
            } else {
                for response in allResponse {
                    let myList = MyAnimeList(response: response)
                    
                    self.fetchAnimeData(myAnimeListResponse: response, completion: { (anime) in
                        myList.anime = anime
                        myAnimeList.append(myList)
                        
                        if myAnimeList.count == allResponse.count {
                            completion(myAnimeList)
                        }
                    })
                }
            }
        }) { (error) in
            self.errorRelay.accept(error.localizedDescription)
        }
    }
    
    private func fetchAnimeData(myAnimeListResponse: MyAnimeListResponse, completion: @escaping (Anime) -> ()) {
        self.anilistManager.fetchAnimePage(animeID: myAnimeListResponse.anime_id!, onSuccess: { (anime) in
            completion(anime)
        }) { (error) in
            self.errorRelay.accept(error.localizedDescription)
        }
    }
}
