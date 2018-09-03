//
//  ReviewHeaderCell.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 3/9/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import Cosmos

class ReviewHeaderCell: UITableViewCell {
    static let nib = UINib(nibName: "ReviewHeaderCell", bundle: .main)
    static let identifier = "ReviewHeaderCell"

    @IBOutlet weak var reviewerImage: UIImageView!
    @IBOutlet weak var reviewerNameLabel: UILabel!
    @IBOutlet weak var reviewDateLabel: UILabel!
    @IBOutlet weak var animeCoverImage: UIImageView!
    @IBOutlet weak var animeNameLabel: UILabel!
    @IBOutlet weak var ratingBar: CosmosView!
    @IBOutlet weak var reviewTitleLabel: UILabel!
    @IBOutlet weak var reviewDescLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpCell(review: Review) {
        reviewerImage.setImageWithRounded(urlStr: (review.user?.image_url_profile)!, borderColor: AnidesuColor.White)
        reviewerNameLabel.text = "Review by " + (review.user?.display_name)!
        reviewDateLabel.text = "Review Date: " + AnidesuConverter.showAnidesuDateTime(timeStr: review.reviewDate)
        animeCoverImage.setImage(urlStr: (review.anime?.imageUrlLarge)!)
        animeNameLabel.text = (review.anime?.titleRomaji)!
        ratingBar.rating = review.rating
        reviewTitleLabel.text = review.title
        reviewDescLabel.text = "\" \(review.desc) \""
    }
    
}
