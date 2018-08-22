//
//  PostViewModel.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 20/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class PostViewModel {
    
    var firebaseManager = FirebaseManager()
    
    let createPostCompleted = PublishSubject<Bool>()
    let errorRelay = PublishRelay<String>()
    
    public func createPost(message: String, completion: @escaping () -> ()) {
        self.firebaseManager.createPost(message: message, onSuccess: {
            self.createPostCompleted.onNext(true)
            completion()
        }) { (error) in
            self.errorRelay.accept(error.localizedDescription)
        }
    }
    
    public func fetchAllPost(completion: @escaping ([PostResponse]) -> ()) {
        self.firebaseManager.fetchAllPost(onSuccess: { (allPost) in
            completion(allPost)
        }) { (error) in
            self.errorRelay.accept(error.localizedDescription)
        }
    }
    
    public func addComment(postKey: String, message: String, completion: @escaping () -> ()) {
        self.firebaseManager.addComment(postKey: postKey, message: message, onSuccess: {
            completion()
        }) { (error) in
            self.errorRelay.accept(error.localizedDescription)
        }
    }
    
    public func fetchAllComment(postKey: String, completion: @escaping ([CommentResponse]) -> ()) {
        self.firebaseManager.fetchAllComment(postKey: postKey, onSuccess: { (allComment) in
            completion(allComment)
        }) { (error) in
            self.errorRelay.accept(error.localizedDescription)
        }
    }
}
