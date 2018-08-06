//
//  FirebaseManager.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 6/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseManager {
    
    func signIn(email: String, password: String, completion: @escaping (Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(error)
                return
            }
            completion(nil)
        }
    }
}
