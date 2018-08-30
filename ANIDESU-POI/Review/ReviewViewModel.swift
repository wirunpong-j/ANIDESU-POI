//
//  ReviewViewModel.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 30/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ReviewViewModel {
    
    var anilistManager = AniListManager()
    var firebaseManager = FirebaseManager()
    let errorRelay = PublishRelay<String>()
    
    public func fetchAllReview(completion: @escaping ([Review]) -> ()) {
        self.firebaseManager.fetchAllReview(onSuccess: { (allResponse) in
            var allReview = [Review]()
            for response in allResponse {
                let review = Review(response: response)
                
                self.anilistManager.fetchAnimePage(animeID: review.animeID!, onSuccess: { (anime) in
                    review.anime = anime
                    
                    self.firebaseManager.fetchUserData(uid: review.uid!, onSuccess: { (userResponse) in
                        review.user = userResponse
                        
                        allReview.append(review)
                        if allReview.count == allResponse.count {
                            allReview = allReview.sorted(by: { $0.reviewDate! > $1.reviewDate! })
                            
                            completion(allReview)
                        }
                        
                    }, onFailure: { (error) in
                        self.errorRelay.accept(error.localizedDescription)
                    })
                    
                }, onFailure: { (error) in
                    self.errorRelay.accept(error.localizedDescription)
                })
            }
        }) { (error) in
            self.errorRelay.accept(error.localizedDescription)
        }
    }
}
