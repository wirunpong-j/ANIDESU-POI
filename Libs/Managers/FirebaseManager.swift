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

public enum MyAnimeListStatus: String {
    case PlanToWatch = "plan to watch"
    case Watching = "watching"
    case Completed = "completed"
    case Dropped = "dropped"
}

class FirebaseManager {
    private func observerManager(router: FirebaseRouter, completion: @escaping ([String: Any]) -> (), onFailure: @escaping (Error) -> ()) {
        let ref = Database.database().reference()
        ref.child(router.path).observeSingleEvent(of: .value, with: { (snapshot) in
            let allData = snapshot.value as! [String: Any]
            completion(allData)
        }) { (error) in
            onFailure(error)
        }
    }
    
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
        let router = FirebaseRouter.setUpProfile(uid: uid, displayName: displayName, email: email, imageURL: imageURL)
        
        ref.child(router.path).setValue(router.parameters) { (error, dataRef) in
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
        let router = FirebaseRouter.createPost(message: message)
        ref.child(router.path).childByAutoId().setValue(router.parameters) { (error, dataRef) in
            if let error = error {
                onFailure(error)
            } else {
                onSuccess()
            }
        }
    }
    
    func fetchAllPost(onSuccess: @escaping ([PostResponse]) -> (), onFailure: @escaping (Error) -> ()) {
        let router = FirebaseRouter.fetchAllPost
        
        self.observerManager(router: router, completion: { (allData) in
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
        let router = FirebaseRouter.fetchUserData(uid: uid)
        
        self.observerManager(router: router, completion: { (allData) in
            let jsonData = try! JSONSerialization.data(withJSONObject: allData)
            let user = try! JSONDecoder().decode(UserResponse.self, from: jsonData)
            onSuccess(user)
        }) { (error) in
            onFailure(error)
        }
    }
    
    public func addComment(postKey: String, message: String, onSuccess: @escaping () -> (), onFailure: @escaping (Error) -> ()) {
        let ref = Database.database().reference()
        let router = FirebaseRouter.comment(postKey: postKey, uid: UserDataModel.instance.uid, message: message)
        
        ref.child(router.path).childByAutoId().setValue(router.parameters) { (error, dataRef) in
            if let error = error {
                onFailure(error)
            } else {
                onSuccess()
            }
        }
    }
    
    public func fetchAllComment(postKey: String, onSuccess: @escaping ([CommentResponse]) -> (), onFailure: @escaping (Error) -> ()) {
        let router = FirebaseRouter.fetchAllComment(postKey: postKey)
        
        self.observerManager(router: router, completion: { (allData) in
            var allComment = [CommentResponse]()

            if !allData.isEmpty {
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
    
    func fetchAllMyAnimeList(status: MyAnimeListStatus, uid: String, onSuccess: @escaping ([MyAnimeListResponse]) -> (), onFailure: @escaping (Error) -> ()) {
        let router = FirebaseRouter.fetchAllMyAnimeList
        
        self.observerManager(router: router, completion: { (allData) in
            var allMyAnimeList = [MyAnimeListResponse]()
            
            if !allData.isEmpty {
                for key in allData.keys {
                    let jsonData = try! JSONSerialization.data(withJSONObject: allData[key])
                    let myAnimeList = try! JSONDecoder().decode(MyAnimeListResponse.self, from: jsonData)
                    myAnimeList.key = key

                    allMyAnimeList.append(myAnimeList)
                    if allMyAnimeList.count == allData.count {
                        allMyAnimeList = allMyAnimeList.filter({ $0.status == status.rawValue })
                        onSuccess(allMyAnimeList)
                    }
                }
            } else {
                onSuccess(allMyAnimeList)
            }
        }) { (error) in
            onFailure(error)
        }
    }
    
    public func addToMyAnimeList(myAnimeList: MyAnimeList, onSuccess: @escaping () -> (), onFailure: @escaping (Error) -> ()) {
        let ref = Database.database().reference()
        let router = FirebaseRouter.addMyAnimeList(animeID: myAnimeList.animeID!, note: myAnimeList.note!, status: myAnimeList.status!, progress: myAnimeList.progress!, score: myAnimeList.score!)
        
        ref.child(router.path).childByAutoId().setValue(router.parameters) { (error, dataRef) in
            if let error = error {
                onFailure(error)
            } else {
                onSuccess()
            }
        }
    }
}
