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
import Hero

class ReviewViewController: BaseViewController {
    
    @IBOutlet weak var reviewTableView: UITableView!
    
    var viewModel: ReviewViewModel!
    var disposeBag = DisposeBag()
    var allReview = [Review]()
    
    override func viewWillAppear(_ animated: Bool) {
        self.setHeroTransition()
        self.setUpTableView()
        self.setUpViewModel()
    }
    
    private func setHeroTransition() {
        self.hero.isEnabled = true
        self.navigationController?.hero.isEnabled = true
        self.navigationController?.hero.navigationAnimationType = .selectBy(presenting: .zoom, dismissing: .zoomOut)
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
                let indexRow = sender as! Int
                viewController.tempHeroID = [MyHeroTransition.reviewBannerImage(row: indexRow),
                                             MyHeroTransition.reviewerImage(row: indexRow)]
                viewController.review = self.allReview[indexRow]
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
            cell.reviewBannerImageView.hero.id = MyHeroTransition.reviewBannerImage(row: indexPath.row).id
            cell.reviewerImage.hero.id = MyHeroTransition.reviewerImage(row: indexPath.row).id
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: ReviewDetailViewController.identifier, sender: indexPath.row)
    }
}
