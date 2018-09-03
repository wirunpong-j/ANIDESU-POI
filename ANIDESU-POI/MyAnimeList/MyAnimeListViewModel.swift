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
    
    let isLoading = PublishSubject<Bool>()
    let errorRelay = PublishRelay<String>()
    
    public func fetchAllMyAnimeList(status: MyAnimeListStatus, completion: @escaping ([MyAnimeList]) -> ()) {
        self.firebaseManager.fetchAllMyAnimeList(status: status, uid: MyProfileModel.instance.uid, onSuccess: { (allResponse) in
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
                            myAnimeList = myAnimeList.sorted(by: { $0.dateTime! > $1.dateTime! })
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
    
    public func updateMyAnimeList(myAnimeList: MyAnimeList, completion: @escaping () -> ()) {
        self.firebaseManager.updateMyAnimeList(myAnimeList: myAnimeList, onSuccess: {
            completion()
        }) { (error) in
            self.errorRelay.accept(error.localizedDescription)
        }
    }
    
    public func removeMyAnimeList(animeID: Int, completion: @escaping () -> ()) {
        self.firebaseManager.removeMyAnimeList(animeID: animeID, onSuccess: {
            completion()
        }) { (error) in
            self.errorRelay.accept(error.localizedDescription)
        }
    }
    
    public func fetchMyAnimeList(animeID: Int, completion: @escaping (MyAnimeList?) -> ()) {
        self.isLoading.onNext(true)
        self.firebaseManager.fetchMyAnimeList(animeID: animeID, onSuccess: { (response) in
            if let response = response {
                let myAnimeList = MyAnimeList(response: response)
                completion(myAnimeList)
            } else {
                completion(nil)
            }
            self.isLoading.onNext(false)
        }) { (error) in
            self.errorRelay.accept(error.localizedDescription)
            self.isLoading.onNext(false)
        }
    }
}
