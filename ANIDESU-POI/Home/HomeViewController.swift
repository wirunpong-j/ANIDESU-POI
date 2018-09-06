//
//  HomeViewController.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 10/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Hero

class HomeViewController: BaseViewController {
    @IBOutlet weak var postTableView: UITableView!
    
    var allPost: [PostResponse]!
    var postViewModel: PostViewModel!
    var disposeBag = DisposeBag()
    
    private enum HomeSection: Int {
        case PrePost, Post
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hero.isEnabled = true
        self.navigationController?.hero.isEnabled = true
        self.navigationController?.hero.navigationAnimationType = .selectBy(presenting: .zoom, dismissing: .zoomOut)
        self.navigationController?.modalPresentationStyle = .overCurrentContext
        
        self.setUpTableView()
        self.setUpViewModel()
    }
    
    private func setUpTableView() {
        self.postTableView.delegate = self
        self.postTableView.dataSource = self
        self.postTableView.estimatedRowHeight = 140
        self.postTableView.rowHeight = UITableViewAutomaticDimension
        self.postTableView.register(PrePostCell.nib, forCellReuseIdentifier: PrePostCell.identifier)
        self.postTableView.register(PostCell.nib, forCellReuseIdentifier: PostCell.identifier)
        
        // set refresh control
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            self.postTableView.refreshControl = refreshControl
        } else {
            self.postTableView.backgroundView = refreshControl
        }
    }
    
    private func setUpViewModel() {
        self.allPost = [PostResponse]()
        self.postViewModel = PostViewModel()
        
        self.postViewModel.errorRelay.subscribe(onNext: { (errorString) in
            self.showAlert(title: "Error", message: errorString)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
        
        self.fetchAllPost()
    }
    
    private func fetchAllPost() {
        self.postViewModel.fetchAllPost { (allPost) in
            self.allPost = allPost
            self.postTableView.reloadData()
        }
    }
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        self.fetchAllPost()
        refreshControl.endRefreshing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case CreatePostViewController.identifier:
            let navbar = segue.destination as? UINavigationController
            if let viewController = navbar?.viewControllers.first as? CreatePostViewController {
                navbar?.hero.isEnabled = true
                navbar?.modalPresentationStyle = .overCurrentContext
                navbar?.hero.modalAnimationType = .selectBy(presenting: .pageIn(direction: .up), dismissing: .pageOut(direction: .down))
                viewController.createPostDelegate = self
            }
        case PostDetailViewController.identifier:
            if let viewController = segue.destination as? PostDetailViewController {
                let indexRow = sender as! Int
                viewController.hero.isEnabled = true
                viewController.post = self.allPost[indexRow]
                viewController.tempHeroId = "detail\(indexRow)"
            }
        default:
            break
        }
    }
}

extension HomeViewController: CreatePostDelegate {
    func createPostCompleted() {
        self.fetchAllPost()
    }
}

extension HomeViewController: PostCellDidTapDelegate {
    func likeBtnDidTap() {
        
    }
    
    func commentBtnDidTap(indexPath: IndexPath) {
        self.performSegue(withIdentifier: PostDetailViewController.identifier, sender: indexPath.row)
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
            return self.allPost.count
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
                cell.setUpCell(post: self.allPost[indexPath.row], isBorder: true)
                cell.indexPath = indexPath
                cell.postCellDidTapDelegate = self
                cell.contentView.hero.id = "detail\(indexPath.row)"
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
            self.performSegue(withIdentifier: PostDetailViewController.identifier, sender: indexPath.row)
        }
    }
}
