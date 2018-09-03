//
//  RegisterViewModel.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 7/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import RxSwift
import RxCocoa

class RegisterViewModel {
    var firebaseManager = FirebaseManager()
    
    let isLoading = PublishSubject<Bool>()
    let errorRelay = PublishRelay<String>()
    
    public func register(displayName: String, email: String, password: String, image: UIImage, completion: @escaping () -> ()) {
        self.isLoading.onNext(true)
        
        let user = UserModel(displayName: displayName, email: email, password: password)
        
        self.firebaseManager.signUp(user: user, image: image, onSuccess: { (imageURL) in
            
            user.uid = (Auth.auth().currentUser?.uid)!
            user.imageUrlProfile = imageURL
            
            self.createInitialUserProfile(user: user, onSuccess: {
                completion()
                self.isLoading.onNext(false)
                
            }, onFailure: { (error) in
                self.errorRelay.accept(error.localizedDescription)
                self.isLoading.onNext(false)
            })
        }, onFailure: { (error) in
            self.errorRelay.accept(error.localizedDescription)
            self.isLoading.onNext(false)
        })
    }
    
    private func createInitialUserProfile(user: UserModel, onSuccess: @escaping () -> (), onFailure: @escaping (Error) -> ()) {
        self.isLoading.onNext(true)
        
        self.firebaseManager.setUpProfile(user: user, onSuccess: {
            onSuccess()
            self.isLoading.onNext(false)
        }, onFailure: { (error) in
            onFailure(error)
            self.isLoading.onNext(false)
        })
    }
}
