//
//  PostCell.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 20/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import WCLShineButton

protocol PostCellDidTapDelegate {
    func likeBtnDidTap()
    func commentBtnDidTap(indexPath: IndexPath)
}

class PostCell: UITableViewCell {
    static let nib = UINib(nibName: "PostCell", bundle: .main)
    static let identifier = "PostCell"
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var likeBtn: WCLShineButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var likeCountBtn: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    var postCellDidTapDelegate: PostCellDidTapDelegate?
    var indexPath: IndexPath?
    
    @IBOutlet weak var bgViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var bgViewRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bgViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var bgViewLeftConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpCell(post: PostResponse, isBorder: Bool) {
        profileImage.setImageWithRounded(urlStr: (post.user?.image_url_profile)!, borderColor: AnidesuColor.Clear)
        displayNameLabel.text = (post.user?.display_name)!
        dateTimeLabel.text = AnidesuConverter.showAnidesuDateTime(timeStr: post.post_date!)
        messageLabel.text = post.message!
        likeCountBtn.text = "\(post.like_count!) Likes"
        likeBtn.addTarget(self, action: #selector(likeBtnPressed), for: .valueChanged)
        self.separatorView.isHidden = true
        
        if isBorder {
            self.setUpBorder()
        } else {
            self.bgViewBottomConstraint.constant = 0
            self.bgViewRightConstraint.constant = 0
            self.bgViewTopConstraint.constant = 0
            self.bgViewLeftConstraint.constant = 0
            self.separatorView.isHidden = false
        }
    }
    
    private func setUpBorder() {
        bgView.layer.shadowColor = AnidesuColor.Black.color().cgColor
        bgView.layer.shadowOffset = CGSize(width: 0, height: 5)
        bgView.layer.shadowOpacity = 0.1
        bgView.layer.shadowRadius = 5
    }
    
    @objc func likeBtnPressed() {
        self.postCellDidTapDelegate?.likeBtnDidTap()
    }
    
    @IBAction func commentBtnPressed(_ sender: Any) {
        self.postCellDidTapDelegate?.commentBtnDidTap(indexPath: self.indexPath!)
    }
}
