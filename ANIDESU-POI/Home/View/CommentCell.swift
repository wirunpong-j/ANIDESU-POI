//
//  CommentCell.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 20/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    static let nib = UINib(nibName: "CommentCell", bundle: .main)
    static let identifier = "CommentCell"

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var commentDateTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpCell(comment: CommentResponse) {
        profileImage.setImageWithRounded(urlStr: (comment.user?.image_url_profile)!, borderColor: AnidesuColor.Clear)
        displayNameLabel.text = (comment.user?.display_name)!
        messageLabel.text = comment.comment_message!
        commentDateTimeLabel.text = Date().showAnidesuDateTime(timeStr: comment.comment_date!)
    }

}
