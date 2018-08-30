//
//  ReviewCell.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 30/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {
    static let nib = UINib(nibName: "ReviewCell", bundle: .main)
    static let identifier = "ReviewCell"
    
    @IBOutlet weak var reviewBannerImageView: UIImageView!
    @IBOutlet weak var animeTitleLabel: UILabel!
    @IBOutlet weak var reviewerImage: UIImageView!
    @IBOutlet weak var reviewerNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpCell(review: Review) {
        if let bannerUrl = review.anime?.imageUrlBanner {
            reviewBannerImageView.setImage(urlStr: bannerUrl)
        } else {
            reviewBannerImageView.setImage(urlStr: (review.anime?.imageUrlLarge)!)
        }
        
        animeTitleLabel.text = (review.anime?.titleRomaji)!
        reviewerImage.setImageWithRounded(urlStr: (review.user?.image_url_profile)!, borderColor: AnidesuColor.White)
        reviewerNameLabel.text = "Review by: " + (review.user?.display_name)!
    }
}
