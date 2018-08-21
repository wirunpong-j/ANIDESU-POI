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
    
    let errorRelay: PublishRelay<String> = PublishRelay()
    
    func fetchListAnimeBySeason(season: AnimeSeason, completion: @escaping ([AnimeResponse]) -> ()) {
            anilistManager.fetchAnimeListBySeason(season: season, onSuccess: { (listAnime) in
                completion(listAnime)
            }) { (error) in
                self.errorRelay.accept(error.localizedDescription)
            }
        }
    }
