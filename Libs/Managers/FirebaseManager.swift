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
import FirebaseFirestore

public enum MyAnimeListStatus: String {
    case PlanToWatch = "plan to watch"
    case Watching = "watching"
    case Completed = "completed"
    case Dropped = "dropped"
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
        let db = Firestore.firestore()
        let router = FirestoreRouter.setUpProfile(uid: uid, displayName: displayName, email: email, imageURL: imageURL)
        
        db.document(router.path).setData(router.parameters!) { (error) in
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
        let db = Firestore.firestore()
        let router = FirestoreRouter.createPost(message: message)
        
        db.collection(router.path).addDocument(data: router.parameters!) { (error) in
            if let error = error {
                onFailure(error)
            } else {
                onSuccess()
            }
        }
    }
    
    func fetchAllPost(onSuccess: @escaping ([PostResponse]) -> (), onFailure: @escaping (Error) -> ()) {
        let db = Firestore.firestore()
        let router = FirestoreRouter.fetchAllPost
        
        db.collection(router.path).getDocuments { (allData, error) in
            if let error = error {
                onFailure(error)
            } else {
                var allPost = [PostResponse]()
                
                if let allData = allData, !allData.isEmpty {
                    for data in allData.documents {
                        let jsonData = try! JSONSerialization.data(withJSONObject: data.data())
                        let post = try! JSONDecoder().decode(PostResponse.self, from: jsonData)
                        post.key = data.documentID
                        
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
                } else {
                    onSuccess(allPost)
                }
            }
        }
    }
    
    public func fetchUserData(uid: String, onSuccess: @escaping (UserResponse) -> (), onFailure: @escaping (Error) -> ()) {
        let db = Firestore.firestore()
        let router = FirestoreRouter.fetchUserData(uid: uid)
        
        db.document(router.path).getDocument { (snapshot, error) in
            if let error = error {
                onFailure(error)
            } else {
                let jsonData = try! JSONSerialization.data(withJSONObject: snapshot!.data())
                let userResponse = try! JSONDecoder().decode(UserResponse.self, from: jsonData)
                
                onSuccess(userResponse)
            }
        }
    }
    
    public func addComment(postKey: String, message: String, onSuccess: @escaping () -> (), onFailure: @escaping (Error) -> ()) {
        let db = Firestore.firestore()
        let router = FirestoreRouter.addComment(postKey: postKey, message: message)
        
        db.collection(router.path).addDocument(data: router.parameters!) { (error) in
            if let error = error {
                onFailure(error)
            } else {
                onSuccess()
            }
        }
    }
    
    public func fetchAllComment(postKey: String, onSuccess: @escaping ([CommentResponse]) -> (), onFailure: @escaping (Error) -> ()) {
        let db = Firestore.firestore()
        let router = FirestoreRouter.fetchAllComment(postKey: postKey)
        
        db.collection(router.path).getDocuments { (allData, error) in
            if let error = error {
                onFailure(error)
            } else {
                var allComment = [CommentResponse]()
                
                if let allData = allData, !allData.isEmpty {
                    for data in allData.documents {
                        let jsonData = try! JSONSerialization.data(withJSONObject: data.data())
                        let comment = try! JSONDecoder().decode(CommentResponse.self, from: jsonData)
                        comment.key = data.documentID
                        
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
            }
        }
    }
    
    func fetchAllMyAnimeList(status: MyAnimeListStatus, uid: String, onSuccess: @escaping ([MyAnimeListResponse]) -> (), onFailure: @escaping (Error) -> ()) {
        let db = Firestore.firestore()
        let router = FirestoreRouter.fetchAllMyAnimeList
        
        db.collection(router.path).getDocuments { (allData, error) in
            if let error = error {
                onFailure(error)
            } else {
                var allMyAnimeList = [MyAnimeListResponse]()
                
                if let allData = allData, !allData.isEmpty {
                    for data in allData.documents {
                        let jsonData = try! JSONSerialization.data(withJSONObject: data.data())
                        let myAnimeList = try! JSONDecoder().decode(MyAnimeListResponse.self, from: jsonData)
                        
                        allMyAnimeList.append(myAnimeList)
                        if allMyAnimeList.count == allData.count {
                            allMyAnimeList = allMyAnimeList.filter({ $0.status == status.rawValue })
                            onSuccess(allMyAnimeList)
                        }
                    }
                } else {
                    onSuccess(allMyAnimeList)
                }
            }
        }
    }
    
    public func updateMyAnimeList(myAnimeList: MyAnimeList, onSuccess: @escaping () -> (), onFailure: @escaping (Error) -> ()) {
        let db = Firestore.firestore()
        let router = FirestoreRouter.updateMyAnimeList(animeID: myAnimeList.animeID!, note: myAnimeList.note!, status: myAnimeList.status!, progress: myAnimeList.progress!, score: myAnimeList.score!)
        
        db.document(router.path).setData(router.parameters!) { (error) in
            if let error = error {
                onFailure(error)
            } else {
                onSuccess()
            }
        }
    }
    
    public func fetchMyAnimeList(animeID: Int, onSuccess: @escaping (MyAnimeListResponse?) -> (), onFailure: @escaping (Error) -> ()) {
        let db = Firestore.firestore()
        let router = FirestoreRouter.fetchMyAnimeList(animeID: animeID)
        
        db.document(router.path).getDocument { (data, error) in
            if let error = error {
                onFailure(error)
            } else {
                if let data = data?.data() {
                    let jsonData = try! JSONSerialization.data(withJSONObject: data)
                    let myAnimeList = try! JSONDecoder().decode(MyAnimeListResponse.self, from: jsonData)
                    
                    onSuccess(myAnimeList)
                } else {
                    onSuccess(nil)
                }
            }
        }
    }
    
    public func removeMyAnimeList(animeID: Int, onSuccess: @escaping () -> (), onFailure: @escaping (Error) -> ()) {
        let db = Firestore.firestore()
        let router = FirestoreRouter.removeMyAnimeList(animeID: animeID)
        
        db.document(router.path).delete { (error) in
            if let error = error {
                onFailure(error)
            } else {
                onSuccess()
            }
        }
    }
    
    public func fetchAllReview(onSuccess: @escaping ([ReviewResponse]) -> (), onFailure: @escaping (Error) -> ()) {
        let db = Firestore.firestore()
        let router = FirestoreRouter.fetchAllReview
        
        db.collection(router.path).getDocuments { (allData, error) in
            if let error = error {
                onFailure(error)
            } else {
                var allReviewResponse = [ReviewResponse]()
                
                if let allData = allData, !allData.isEmpty {
                    for data in allData.documents {
                        let jsonData = try! JSONSerialization.data(withJSONObject: data.data())
                        let reviewResponse = try! JSONDecoder().decode(ReviewResponse.self, from: jsonData)
                        allReviewResponse.append(reviewResponse)
                    }
                }
                onSuccess(allReviewResponse)
            }
        }
    }
    
    public func fetchReviewPage(animeID: Int, onSuccess: @escaping (ReviewResponse?) -> (), onFailure: @escaping (Error) -> ()) {
        let db = Firestore.firestore()
        let router = FirestoreRouter.fetchReviewPage
        
        db.collection(router.path)
            .whereField("anime_id", isEqualTo: animeID)
            .whereField("uid", isEqualTo: UserDataModel.instance.uid).getDocuments { (data, error) in
            if let error = error {
                onFailure(error)
            } else {
                if let data = data?.documents, !data.isEmpty {
                    let jsonData = try! JSONSerialization.data(withJSONObject: data[0].data())
                    let reviewResponse = try! JSONDecoder().decode(ReviewResponse.self, from: jsonData)
                    reviewResponse.key = data[0].documentID
                    onSuccess(reviewResponse)
                } else {
                    onSuccess(nil)
                }
            }
        }
    }
    
    public func addReviewAnime(review: Review, onSuccess: @escaping () -> (), onFailure: @escaping (Error) -> ()) {
        let db = Firestore.firestore()
        let router = FirestoreRouter.addReviewAnime(animeID: review.animeID, title: review.title, desc: review.desc, rating: review.rating, reviewDate: review.reviewDate, uid: review.uid)
        
        db.collection(router.path).addDocument(data: router.parameters!) { (error) in
            if let error = error {
                onFailure(error)
            } else {
                onSuccess()
            }
        }
    }
    
    public func updateReviewAnime(review: Review, onSuccess: @escaping () -> (), onFailure: @escaping (Error) -> ()) {
        let db = Firestore.firestore()
        let router = FirestoreRouter.updateReviewAnime(key: review.key, animeID: review.animeID, title: review.title, desc: review.desc, rating: review.rating, reviewDate: review.reviewDate, uid: review.uid)
        
        db.document(router.path).setData(router.parameters!) { (error) in
            if let error = error {
                onFailure(error)
            } else {
                onSuccess()
            }
        }
    }
}
