//
//  CreatePostViewController.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 20/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import UITextView_Placeholder

protocol CreatePostDelegate {
    func createPostCompleted()
}

class CreatePostViewController: BaseViewController {
    static let identifier = "CreatePostViewController"
    
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    
    var postViewModel: PostViewModel!
    let disposeBag = DisposeBag()
    var createPostDelegate: CreatePostDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViewModel()
        self.setUpView()
    }
    
    private func setUpViewModel() {
        self.postViewModel = PostViewModel()
        
        self.postViewModel.errorRelay.subscribe(onNext: { (errorString) in
            self.showAlert(title: "Error", message: errorString)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
        
        self.postViewModel.isLoading.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showLoading()
            } else {
                self.hideLoading()
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
    }
    
    private func setUpView() {
        self.messageTextView.delegate = self
        self.profileImage.setImageWithRounded(urlStr: MyProfileModel.instance.imageUrlProfile, borderColor: AnidesuColor.Clear)
        self.displayNameLabel.text = MyProfileModel.instance.displayName
        self.aboutLabel.text = MyProfileModel.instance.about
    }
    
    @IBAction func shareBtnPressed(_ sender: Any) {
        let message = messageTextView.text!
        self.postViewModel.createPost(message: message) {
            self.dismiss(animated: true, completion: {
                self.createPostDelegate.createPostCompleted()
            })
        }
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            self.createPostDelegate.createPostCompleted()
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension CreatePostViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            shareBtn.isEnabled = false
        } else {
            shareBtn.isEnabled = true
        }
    }
}
