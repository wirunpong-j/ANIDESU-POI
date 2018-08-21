//
//  PostDetailViewController.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 20/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

class PostDetailViewController: BaseViewController {
    static let identifier = "PostDetailViewController"
    
    @IBOutlet weak var postDetailTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextView!
    @IBOutlet weak var commentBtn: UIButton!
    
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
        
    }
    
    private func setUpView() {
        self.title = (post.user?.display_name)! + "'s Post"
        self.setTapGestureRecognizer()
        self.setAutoKeyBoard()
    }
    
    private func setAutoKeyBoard() {
        
    }
    
    private func setTapGestureRecognizer() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
            return 0
//            return (self.post.comments?.count)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch PostSection(rawValue: indexPath.section)! {
        case .PostDetail:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier, for: indexPath) as? PostCell {
                cell.setUpCell(post: post, isBorder: false)
                return cell
            }
        case .Comments:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.identifier, for: indexPath) as? CommentCell {
                return cell
            }
        }
        
        return UITableViewCell()
    }
}
