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
    let errorRelay: PublishRelay<String> = PublishRelay()
    
    func login(email: String, password: String, completion: @escaping () -> ()) {
        firebaseManager.signIn(email: email, password: password, success: {
            completion()
        }) { (error) in
            self.errorRelay.accept(error.localizedDescription)
        }
    }
}
