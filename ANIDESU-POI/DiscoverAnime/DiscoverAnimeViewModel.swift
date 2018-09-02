//
//  DiscoverAnimeViewModel.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 15/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class DiscoverAnimeViewModel {
    
    var anilistManager = AniListManager()
    var listAnime = [AnimeResponse]()
    var isLoading = PublishSubject<Bool>()
    
    let errorRelay: PublishRelay<String> = PublishRelay()
    
    func fetchListAnimeBySeason(season: AnimeSeason, completion: @escaping ([Anime]) -> ()) {
        self.anilistManager.fetchAnimeListBySeason(season: season, onSuccess: { (listAnime) in
            completion(listAnime)
        }) { (error) in
            self.errorRelay.accept(error.localizedDescription)
        }
    }
    
    func fetchAnimePage(animeID: Int, completion: @escaping (Anime) -> ()) {
        self.isLoading.onNext(true)
        self.anilistManager.fetchAnimePage(animeID: animeID, onSuccess: { (anime) in
            completion(anime)
            self.isLoading.onNext(false)
        }) { (error) in
            self.errorRelay.accept(error.localizedDescription)
            self.isLoading.onNext(false)
        }
    }
}
