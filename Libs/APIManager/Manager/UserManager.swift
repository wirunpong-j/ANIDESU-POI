//
//  UserManager.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 15/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation
import Firebase

class UserManager {
    
    var user = MyProfileModel.instance
    
    func getUserData(onCompleted: @escaping () -> (), onFailure: @escaping (Error) -> ()) {
        let db = Firestore.firestore()
        
        let currentUser = Auth.auth().currentUser
        let router = FirestoreRouter.fetchUserData(uid: (currentUser?.uid)!)
        
        db.document(router.path).getDocument { (data, error) in
            if let error = error {
                onFailure(error)
            } else {
                if let data = data {
                    let jsonData = try! JSONSerialization.data(withJSONObject: data.data())
                    let userResponse = try! JSONDecoder().decode(UserResponse.self, from: jsonData)
                    
                    self.user.uid = userResponse.uid!
                    self.user.displayName = userResponse.display_name!
                    self.user.email = userResponse.email!
                    self.user.imageUrlProfile = userResponse.image_url_profile!
                    self.user.about = userResponse.about!
                    
                    onCompleted()
                    
                }
            }
        }
        
//        ref.child(router.path).observeSingleEvent(of: .value, with: { (snapshot) in
//            // get user data
//            let data = snapshot.value as! NSDictionary
//            self.user.uid = data["uid"] as! String
//            self.user.display_name = data["display_name"] as! String
//            self.user.email = data["email"] as! String
//            self.user.image_url_profile = data["image_url_profile"] as! String
//            self.user.about = data["about"] as! String
//            onCompleted()
//        }) { (error) in
//            onFailure(error)
//        }
    }
}
