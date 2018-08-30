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
    
    var user = UserDataModel.instance
    let ref = Database.database().reference()
    
    func getUserData(onCompleted: @escaping () -> (), onFailure: @escaping (Error) -> ()) {
        let currentUser = Auth.auth().currentUser
        let router = FirebaseRouter.fetchUserData(uid: (currentUser?.uid)!)
        ref.child(router.path).observeSingleEvent(of: .value, with: { (snapshot) in
            // get user data
            let data = snapshot.value as! NSDictionary
            self.user.uid = data["uid"] as! String
            self.user.display_name = data["display_name"] as! String
            self.user.email = data["email"] as! String
            self.user.image_url_profile = data["image_url_profile"] as! String
            self.user.about = data["about"] as! String
            onCompleted()
        }) { (error) in
            onFailure(error)
        }
    }
}
