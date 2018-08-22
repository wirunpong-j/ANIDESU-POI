//
//  PostDetailViewController.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 20/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import IHKeyboardAvoiding

class PostDetailViewController: BaseViewController {
    static let identifier = "PostDetailViewController"
    
    @IBOutlet weak var postDetailTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextView!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var sendBtn: AnidesuButton!
    
    var postViewModel: PostViewModel!
    var disposeBag = DisposeBag()
    var post: PostResponse!
    
    private enum PostSection: Int {
        case PostDetail, Comments
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTableView()
        self.setUpViewModel()
        self.setUpView()
    }
    
    private func setUpTableView() {
        self.postDetailTableView.delegate = self
        self.postDetailTableView.dataSource = self
        self.postDetailTableView.estimatedRowHeight = 140
        self.postDetailTableView.rowHeight = UITableViewAutomaticDimension
        self.postDetailTableView.register(PostCell.nib, forCellReuseIdentifier: PostCell.identifier)
    }
    
    private func setUpViewModel() {
        self.postViewModel = PostViewModel()
        
        self.postViewModel.errorRelay.subscribe(onNext: { (errorString) in
            self.showAlert(title: "Error", message: errorString)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
        
        self.reloadData()
    }
    
    private func setUpView() {
        KeyboardAvoiding.avoidingView = self.commentView
        self.messageTextField.delegate = self
        
        self.title = (post.user?.display_name)! + "'s Post"
        let btnImage = UIImage(named: "ic_send")!
        let tintImage = btnImage.withRenderingMode(.alwaysTemplate)
        self.sendBtn.setImage(tintImage, for: .normal)
        self.sendBtn.switchButton(isEnabled: false, tintColor: AnidesuColor.DarkGray)
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        let message = messageTextField.text!
        self.view.endEditing(true)
        
        self.postViewModel.addComment(postKey: post.key!, message: message) {
            self.reloadData()
            self.clearTextView()
        }
    }
    
    private func clearTextView() {
        self.messageTextField.text = "Write a comment..."
        self.messageTextField.textColor = AnidesuColor.DarkGray.color()
        self.sendBtn.switchButton(isEnabled: false, tintColor: AnidesuColor.Gray)
    }
    
    private func reloadData() {
        self.postViewModel.fetchAllComment(postKey: self.post.key!) { (allComment) in
            self.post.comments = allComment
            self.postDetailTableView.reloadData()
        }
    }
}

extension PostDetailViewController: UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            self.sendBtn.switchButton(isEnabled: false, tintColor: AnidesuColor.Gray)
        } else {
            self.sendBtn.switchButton(isEnabled: true, tintColor: AnidesuColor.MiddleBlue)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Write a comment..." {
            textView.text = ""
            textView.textColor = AnidesuColor.DarkBlue.color()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            self.clearTextView()
        }
    }
}

extension PostDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch PostSection(rawValue: section)! {
        case .PostDetail:
            return 1
        case .Comments:
            return self.post.comments != nil ? (self.post.comments?.count)! : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch PostSection(rawValue: indexPath.section)! {
        case .PostDetail:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier, for: indexPath) as? PostCell {
                cell.setUpCell(post: self.post, isBorder: false)
                return cell
            }
        case .Comments:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.identifier, for: indexPath) as? CommentCell {
                cell.setUpCell(comment: self.post.comments![indexPath.row])
                cell.layoutIfNeeded()
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
    }
}
