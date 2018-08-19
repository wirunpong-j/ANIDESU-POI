//
//  LoginViewModel.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 6/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation
import Firebase
import RxSwift
import RxCocoa

class LoginViewModel {
    
    var firebaseManager = FirebaseManager()
    var userManager = UserManager()
    var anilistManager = AniListManager()
    let errorRelay: PublishRelay<String> = PublishRelay()
    
    func login(email: String, password: String, completion: @escaping () -> ()) {
        firebaseManager.signIn(email: email, password: password, onSuccess: {
            self.getUserData {
                completion()
            }
        }) { (error) in
            self.errorRelay.accept(error.localizedDescription)
        }
    }
    
    func getUserData(completion: @escaping () -> ()) {
        userManager.getUserData(onCompleted: {
            self.authenAnilist(completion: {
                completion()
            })
        }) { (error) in
            self.errorRelay.accept(error.localizedDescription)
        }
    }
    
    private func authenAnilist(completion: @escaping () -> ()) {
        anilistManager.authenAnilist(onCompleted: {
            completion()
        }) { (error) in
            self.errorRelay.accept(error.localizedDescription)
        }
    }
}
