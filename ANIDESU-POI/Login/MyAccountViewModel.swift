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

class MyAccountViewModel {
    
    var userManager = UserManager()
    var firebaseManager = FirebaseManager()
    var anilistManager = AniListManager()
    
    let isLoading = PublishSubject<Bool>()
    let errorRelay = PublishRelay<String>()
    
    public func login(email: String, password: String, completion: @escaping () -> ()) {
        self.isLoading.onNext(true)
        
        self.firebaseManager.signIn(email: email, password: password, onSuccess: {
            self.getCurrentUser(isCurrent: { (isCurrent) in
                if isCurrent {
                    completion()
                }
                self.isLoading.onNext(false)
            })
        }) { (error) in
            self.errorRelay.accept(error.localizedDescription)
            self.isLoading.onNext(false)
        }
    }
    
    public func logout(completion: @escaping () -> ()) {
        self.isLoading.onNext(true)
        
        self.firebaseManager.signOut(onSuccess: {
            completion()
            self.isLoading.onNext(false)
        }) { (error) in
            self.errorRelay.accept(error.localizedDescription)
            self.isLoading.onNext(false)
        }
    }
    
    public func getCurrentUser(isCurrent: @escaping (Bool) -> ()) {
        self.isLoading.onNext(true)
        
        if Auth.auth().currentUser != nil {
            self.userManager.getUserData(onCompleted: {
                self.authenAnilist(completion: {
                    isCurrent(true)
                    self.isLoading.onNext(false)
                })
            }) { (error) in
                self.errorRelay.accept(error.localizedDescription)
                self.isLoading.onNext(false)
            }
        } else {
            isCurrent(false)
            self.isLoading.onNext(false)
        }
    }
    
    private func authenAnilist(completion: @escaping () -> ()) {
        self.isLoading.onNext(true)
        
        self.anilistManager.authenAnilist(onCompleted: {
            completion()
            self.isLoading.onNext(false)
        }) { (error) in
            self.errorRelay.accept(error.localizedDescription)
            self.isLoading.onNext(false)
        }
    }
}
