//
//  LoginViewModel.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 6/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation
import Firebase

class LoginViewModel {
    
    var firebaseManager = FirebaseManager()
    
    func login(email: String, password: String, completion: @escaping (Error?) -> ()) {
        firebaseManager.signIn(email: email, password: password) { (error) in
            if let error = error {
                completion(error)
                return
            }
            completion(nil)
        }
    }
}
