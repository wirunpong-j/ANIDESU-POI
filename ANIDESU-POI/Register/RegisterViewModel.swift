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
    let errorRelay: PublishRelay<String> = PublishRelay()
    
    func register(displayName: String, email: String, password: String, image: UIImage, completion: @escaping () -> ()) {
        firebaseManager.signUp(displayName: displayName, email: email, password: password, image: image, success: { (imageURL) in
            self.createInitialUserProfile(uid: (Auth.auth().currentUser?.uid)!, displayName: displayName, email: email, imageURL: imageURL, success: {
                completion()
                
            }, failure: { (error) in
                self.errorRelay.accept(error.localizedDescription)
            })
        }, failure: { (error) in
            self.errorRelay.accept(error.localizedDescription)
        })
    }
    
    private func createInitialUserProfile(uid: String, displayName: String, email: String, imageURL: String, success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        firebaseManager.setUpProfile(uid: uid, displayName: displayName, email: email, imageURL: imageURL, success: {
            success()
        }, failure: { (error) in
            failure(error)
        })
    }
    
}
