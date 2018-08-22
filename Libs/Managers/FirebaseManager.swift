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
    case post
    case comment(postKey: String)
    
    func getUrl() -> String {
        switch self {
        case .userData(let uid):
            return "anidesu/users/\(uid)/profile"
        case .post:
            return "anidesu/posts"
        case .comment(let postKey):
            return "anidesu/posts/\(postKey)/comment"
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
    
    func createPost(message: String, onSuccess: @escaping () -> (), onFailure: @escaping (Error) -> ()) {
        let ref = Database.database().reference()
        let postInfo: [String: Any] = [
            "uid": UserDataModel.instance.uid,
            "message": message,
            "post_date": Date().getCurrentTime(),
            "like_count": 0
        ]
        ref.child(FirebaseUrl.post.getUrl()).childByAutoId().setValue(postInfo) { (error, dataRef) in
            if let error = error {
                onFailure(error)
            } else {
                onSuccess()
            }
        }
    }
    
    func fetchAllPost(onSuccess: @escaping ([PostResponse]) -> (), onFailure: @escaping (Error) -> ()) {
        let ref = Database.database().reference()
        ref.child(FirebaseUrl.post.getUrl()).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let allData = snapshot.value as! [String: Any]
            var allPost = [PostResponse]()
            
            for key in allData.keys {
                let jsonData = try! JSONSerialization.data(withJSONObject: allData[key])
                let post = try! JSONDecoder().decode(PostResponse.self, from: jsonData)
                post.key = key
                self.fetchUserData(uid: post.uid!, onSuccess: { (userResponse) in
                    post.user = userResponse
                    allPost.append(post)
                    
                    if allPost.count == allData.count {
                        allPost = allPost.sorted(by: { $0.post_date! > $1.post_date! })
                        onSuccess(allPost)
                    }
                }, onFailure: { (error) in
                    onFailure(error)
                })
            }
        }) { (error) in
            onFailure(error)
        }
    }
    
    private func fetchUserData(uid: String, onSuccess: @escaping (UserResponse) -> (), onFailure: @escaping (Error) -> ()) {
        let ref = Database.database().reference()
        ref.child(FirebaseUrl.userData(uid: uid).getUrl()).observeSingleEvent(of: .value, with: { (snaphot) in
            let jsonData = try! JSONSerialization.data(withJSONObject: snaphot.value)
            let user = try! JSONDecoder().decode(UserResponse.self, from: jsonData)
            onSuccess(user)
        }) { (error) in
            onFailure(error)
        }
    }
    
    public func addComment(postKey: String, message: String, onSuccess: @escaping () -> (), onFailure: @escaping (Error) -> ()) {
        let ref = Database.database().reference()
        let commentInfo: [String: Any] = [
            "uid": UserDataModel.instance.uid,
            "comment_message": message,
            "comment_date": Date().getCurrentTime()
        ]
        
        ref.child(FirebaseUrl.comment(postKey: postKey).getUrl()).childByAutoId().setValue(commentInfo) { (error, dataRef) in
            if let error = error {
                onFailure(error)
            } else {
                onSuccess()
            }
        }
    }
    
    public func fetchAllComment(postKey: String, onSuccess: @escaping ([CommentResponse]) -> (), onFailure: @escaping (Error) -> ()) {
        let ref = Database.database().reference()
        ref.child(FirebaseUrl.comment(postKey: postKey).getUrl()).observeSingleEvent(of: .value, with: { (snapshot) in
            var allComment = [CommentResponse]()
            
            if let allData = snapshot.value as? [String: Any] {
                for key in allData.keys {
                    let jsonData = try! JSONSerialization.data(withJSONObject: allData[key])
                    let comment = try! JSONDecoder().decode(CommentResponse.self, from: jsonData)
                    comment.key = key
                    
                    self.fetchUserData(uid: comment.uid!, onSuccess: { (userResponse) in
                        comment.user = userResponse
                        allComment.append(comment)
                        
                        if allComment.count == allData.count {
                            allComment = allComment.sorted(by: { $0.comment_date! < $1.comment_date! })
                            onSuccess(allComment)
                        }
                    }, onFailure: { (error) in
                        onFailure(error)
                    })
                }
            } else {
                onSuccess(allComment)
            }
        }) { (error) in
            onFailure(error)
        }
    }
}
