//
//  FirebaseManager.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 6/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class FirebaseManager {
    
    func signIn(email: String, password: String, success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                failure(error)
            } else {
                success()
            }
        }
    }
    
    func signUp(displayName: String, email: String, password: String, image: UIImage, success: @escaping (String) -> (), failure: @escaping (Error) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error == nil {
                self.uploadImage(image: image, uid: (result?.user.uid)!, success: { (url) in
                    success(url.absoluteString)
                }, failure: { (error) in
                    failure(error)
                })
            } else {
                failure(error!)
            }
        }
    }
    
    func setUpProfile(uid: String, displayName: String, email: String, imageURL: String, success: @escaping () -> (), failure: @escaping (Error) -> ()) {
        let ref = Database.database().reference()
        let information: [String: Any] = [
            "uid": uid,
            "display_name": displayName,
            "email": email,
            "image_url_profile": imageURL,
            "about": "Welcome To AniDesu."]
        ref.child("ios").child("users").child(uid).child("profile").setValue(information) { (error, dataRef) in
            if let error = error {
                failure(error)
            } else {
                success()
            }
        }
    }
    
    private func uploadImage(image: UIImage, uid: String, success: @escaping (URL) -> (), failure: @escaping (Error) -> ()) {
        let data = image.jpeg(.high)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        let imagesRef = Storage.storage().reference().child("profileImages/\(uid).jpg")
        imagesRef.putData(data!, metadata: metadata) { (result, error) in
            if error == nil {
                imagesRef.downloadURL(completion: { (url, downloadError) in
                    if downloadError == nil {
                        success(url!)
                    } else {
                        failure(downloadError!)
                    }
                })
            } else {
                failure(error!)
            }
        }
    }
}
