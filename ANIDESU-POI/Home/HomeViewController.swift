//
//  HomeViewController.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 10/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewController: BaseViewController {
    @IBOutlet weak var postTableView: UITableView!
    
    private enum HomeSection: Int {
        case PrePost, Post
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViewModel()
        self.setUpNib()
        self.setUpView()
    }
    
    func setUpNib() {
        self.postTableView.delegate = self
        self.postTableView.dataSource = self
        self.postTableView.estimatedRowHeight = 140
        self.postTableView.rowHeight = UITableViewAutomaticDimension
        self.postTableView.register(PrePostCell.nib, forCellReuseIdentifier: PrePostCell.identifier)
        self.postTableView.register(PostCell.nib, forCellReuseIdentifier: PostCell.identifier)
    }
    
    func setUpView() {
        
    }
    
    func setUpViewModel() {
        
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch HomeSection(rawValue: section)! {
        case .PrePost:
            return 1
        case .Post:
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch HomeSection(rawValue: indexPath.section)! {
        case .PrePost:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PrePostCell.identifier, for: indexPath) as? PrePostCell {
                return cell
            }
        case .Post:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier, for: indexPath) as? PostCell {
                cell.setUpCell()
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch HomeSection(rawValue: indexPath.section)! {
        case .PrePost:
            self.performSegue(withIdentifier: CreatePostViewController.identifier, sender: nil)
        case .Post:
            break
        }
    }
}
