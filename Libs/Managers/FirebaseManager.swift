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

public enum FirebaseUrl {
    case userData(uid: String)
    
    func getUrl() -> String {
        switch self {
        case .userData(let uid):
            return "anidesu/users/\(uid)/profile"
        }
    }
}

class FirebaseManager {
    
    func signIn(email: String, password: String, onSuccess: @escaping () -> (), onFailure: @escaping (Error) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                onFailure(error)
            } else {
                onSuccess()
            }
        }
    }
    
    func signUp(displayName: String, email: String, password: String, image: UIImage, onSuccess: @escaping (String) -> (), onFailure: @escaping (Error) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error == nil {
                self.uploadImage(image: image, uid: (result?.user.uid)!, onSuccess: { (url) in
                    onSuccess(url.absoluteString)
                }, onFailure: { (error) in
                    onFailure(error)
                })
            } else {
                onFailure(error!)
            }
        }
    }
    
    func setUpProfile(uid: String, displayName: String, email: String, imageURL: String, onSuccess: @escaping () -> (), onFailure: @escaping (Error) -> ()) {
        let ref = Database.database().reference()
        let information: [String: Any] = [
            "uid": uid,
            "display_name": displayName,
            "email": email,
            "image_url_profile": imageURL,
            "about": "Welcome To AniDesu."]
        ref.child("anidesu").child("users").child(uid).child("profile").setValue(information) { (error, dataRef) in
            if let error = error {
                onFailure(error)
            } else {
                onSuccess()
            }
        }
    }
    
    private func uploadImage(image: UIImage, uid: String, onSuccess: @escaping (URL) -> (), onFailure: @escaping (Error) -> ()) {
        let data = image.jpeg(.high)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        let imagesRef = Storage.storage().reference().child("profileImages/\(uid).jpg")
        imagesRef.putData(data!, metadata: metadata) { (result, error) in
            if error == nil {
                imagesRef.downloadURL(completion: { (url, downloadError) in
                    if downloadError == nil {
                        onSuccess(url!)
                    } else {
                        onFailure(downloadError!)
                    }
                })
            } else {
                onFailure(error!)
            }
        }
    }
}
