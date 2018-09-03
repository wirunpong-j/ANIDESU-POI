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
    
    let isLoading = PublishSubject<Bool>()
    let errorRelay = PublishRelay<String>()
    
    public func createPost(message: String, completion: @escaping () -> ()) {
        self.isLoading.onNext(true)
        
        self.firebaseManager.createPost(message: message, onSuccess: {
            completion()
            self.isLoading.onNext(false)
        }) { (error) in
            self.errorRelay.accept(error.localizedDescription)
            self.isLoading.onNext(false)
        }
    }
    
    public func fetchAllPost(completion: @escaping ([PostResponse]) -> ()) {
        self.isLoading.onNext(true)
        
        self.firebaseManager.fetchAllPost(onSuccess: { (allPost) in
            completion(allPost)
            self.isLoading.onNext(false)
        }) { (error) in
            self.errorRelay.accept(error.localizedDescription)
            self.isLoading.onNext(false)
        }
    }
    
    public func addComment(postKey: String, message: String, completion: @escaping () -> ()) {
        self.isLoading.onNext(true)
        
        self.firebaseManager.addComment(postKey: postKey, message: message, onSuccess: {
            completion()
            self.isLoading.onNext(false)
        }) { (error) in
            self.errorRelay.accept(error.localizedDescription)
            self.isLoading.onNext(false)
        }
    }
    
    public func fetchAllComment(postKey: String, completion: @escaping ([CommentResponse]) -> ()) {
        self.isLoading.onNext(true)
        
        self.firebaseManager.fetchAllComment(postKey: postKey, onSuccess: { (allComment) in
            completion(allComment)
            self.isLoading.onNext(false)
        }) { (error) in
            self.errorRelay.accept(error.localizedDescription)
            self.isLoading.onNext(false)
        }
    }
}
