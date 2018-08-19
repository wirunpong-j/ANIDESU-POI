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
    var ALL_SEASON = [AnimeSeason.Winter, AnimeSeason.Spring, AnimeSeason.Fall, AnimeSeason.Summer]
    var winter = [AnimeResponse]()
    var spring = [AnimeResponse]()
    var fall = [AnimeResponse]()
    var summer = [AnimeResponse]()
    
    let errorRelay: PublishRelay<String> = PublishRelay()
    
    func fetchAnimeAllSeason(currentViewController: UIViewController, completion: @escaping ([UIViewController]) -> ()) {
        var count = 0
        var menuViewController = [UIViewController]()
        
        for season in ALL_SEASON {
            anilistManager.fetchAnimeListBySeason(season: season, onSuccess: { (listAnime) in
                switch season {
                case .Winter:
                    self.winter = listAnime
                case .Spring:
                    self.spring = listAnime
                case .Fall:
                    self.fall = listAnime
                case .Summer:
                    self.summer = listAnime
                }
                count += 1
                
                if count == self.ALL_SEASON.count {
                    let winterViewController = self.setDiscoverAnimeViewController(listAnime: self.winter, currentViewController: currentViewController)
                    let springViewController = self.setDiscoverAnimeViewController(listAnime: self.spring, currentViewController: currentViewController)
                    let fallViewController = self.setDiscoverAnimeViewController(listAnime: self.fall, currentViewController: currentViewController)
                    let summerViewController = self.setDiscoverAnimeViewController(listAnime: self.summer, currentViewController: currentViewController)
                    
                    menuViewController = [winterViewController, springViewController, fallViewController, summerViewController]
                    completion(menuViewController)
                }
                
            }) { (error) in
                self.errorRelay.accept(error.localizedDescription)
            }
        }
    }
    
    private func setDiscoverAnimeViewController(listAnime: [AnimeResponse], currentViewController: UIViewController) -> UIViewController {
        let viewController = currentViewController.storyboard?.instantiateViewController(withIdentifier: DiscoverAnimeViewController.identifier) as? DiscoverAnimeViewController
        viewController?.listAnime = listAnime
        return viewController!
    }
}
