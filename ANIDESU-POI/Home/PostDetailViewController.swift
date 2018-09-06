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
import Hero

class PostDetailViewController: BaseViewController {
    static let identifier = "PostDetailViewController"
    
    @IBOutlet weak var postDetailTableView: UITableView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var sendBtn: AnidesuButton!
    
    var tempHeroId: String?
    
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
        
        self.view.isOpaque = false
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
        
        self.postViewModel.isLoading.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showLoading()
            } else {
                self.hideLoading()
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
        
        self.postViewModel.fetchAllComment(postKey: self.post.key!) { (allComment) in
            self.post.comments = allComment
            self.postDetailTableView.reloadData()
        }
    }
    
    private func setUpView() {
        KeyboardAvoiding.avoidingView = self.commentView
        self.messageTextView.delegate = self
        
        self.title = (post.user?.display_name)! + "'s Post"
        let btnImage = UIImage(named: "ic_send")!
        let tintImage = btnImage.withRenderingMode(.alwaysTemplate)
        self.sendBtn.setImage(tintImage, for: .normal)
        self.sendBtn.switchButton(isEnabled: false, tintColor: AnidesuColor.DarkGray)
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        self.view.endEditing(true)
        
        let message = messageTextView.text!
        self.clearTextView()
        
        self.postViewModel.addComment(postKey: post.key!, message: message) {
            self.postViewModel.fetchAllComment(postKey: self.post.key!, completion: { (allComment) in
                self.post.comments = allComment
                let indexPath = IndexPath(row: allComment.count - 1, section: PostSection.Comments.rawValue)
                self.postDetailTableView.insertRows(at: [indexPath], with: .fade)
                self.postDetailTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            })
        }
    }
    
    private func clearTextView() {
        self.messageTextView.text = ""
        self.sendBtn.switchButton(isEnabled: false, tintColor: AnidesuColor.Gray)
    }
}

extension PostDetailViewController: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            self.sendBtn.switchButton(isEnabled: false, tintColor: AnidesuColor.Gray)
        } else {
            self.sendBtn.switchButton(isEnabled: true, tintColor: AnidesuColor.Blue)
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
                cell.contentView.hero.id = self.tempHeroId!
                return cell
            }
        case .Comments:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.identifier, for: indexPath) as? CommentCell {
                cell.setUpCell(comment: self.post.comments![indexPath.row])
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
    }
}
