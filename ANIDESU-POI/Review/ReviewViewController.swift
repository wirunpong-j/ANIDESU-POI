//
//  ReviewViewController.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 30/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ReviewViewController: BaseViewController {
    
    @IBOutlet weak var reviewTableView: UITableView!
    
    var viewModel: ReviewViewModel!
    var disposeBag = DisposeBag()
    var allReview = [Review]()
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUpTableView()
        self.setUpViewModel()
    }
    
    private func setUpTableView() {
        self.reviewTableView.delegate = self
        self.reviewTableView.dataSource = self
        self.reviewTableView.estimatedRowHeight = 180
        self.reviewTableView.register(ReviewCell.nib, forCellReuseIdentifier: ReviewCell.identifier)
    }
    
    private func setUpViewModel() {
        self.viewModel = ReviewViewModel()
        
        self.viewModel.errorRelay.subscribe(onNext: { (errorString) in
            self.showAlert(title: "Error", message: errorString)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
        
        self.viewModel.fetchAllReview { (allReview) in
            self.allReview = allReview
            self.reviewTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.setBackButton()
        
        if segue.identifier == ReviewDetailViewController.identifier {
            if let viewController = segue.destination as? ReviewDetailViewController {
                viewController.review = sender as? Review
            }
        }
    }
    
    private func setBackButton() {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
    }
}

extension ReviewViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allReview.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.identifier) as? ReviewCell {
            cell.setUpCell(review: self.allReview[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: ReviewDetailViewController.identifier, sender: self.allReview[indexPath.row])
    }
}
