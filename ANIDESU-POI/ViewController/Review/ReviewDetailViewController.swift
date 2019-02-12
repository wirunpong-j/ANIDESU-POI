//
//  ReviewDetailViewController.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 3/9/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

class ReviewDetailViewController: BaseViewController {
    static let identifier = "ReviewDetailViewController"
    
    @IBOutlet weak var reviewDetailTableView: UITableView!
    @IBOutlet weak var animeBannerImage: UIImageView!
    
    var review: Review?
    var tempHeroID: [MyHeroTransition]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setHeroTransition()
        self.setUpTableView()
        self.setUpView()
    }
    
    private func setHeroTransition() {
        self.animeBannerImage.hero.id = self.tempHeroID![0].id
    }
    
    private func setUpTableView() {
        self.reviewDetailTableView.delegate = self
        self.reviewDetailTableView.dataSource = self
        self.reviewDetailTableView.register(ReviewHeaderCell.nib, forCellReuseIdentifier: ReviewHeaderCell.identifier)
    }
    
    private func setUpView() {
        self.title = "Review"
        self.navigationController?.navigationBar.tintColor = AnidesuColor.White.color()
        self.animeBannerImage.setImage(urlStr: (self.review?.anime?.imageUrlBanner)!)
    }

}

extension ReviewDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ReviewHeaderCell.identifier) as? ReviewHeaderCell {
            cell.setUpCell(review: self.review!)
            cell.reviewerImage.hero.id = self.tempHeroID![1].id
            return cell
        }
        
        return UITableViewCell()
    }
}
