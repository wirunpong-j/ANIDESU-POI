//
//  PostCell.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 20/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import WCLShineButton

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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpCell() {
        self.setUpBorder()
    }
    
    private func setUpBorder() {
        bgView.layer.shadowColor = AnidesuColor.Black.color().cgColor
        bgView.layer.shadowOffset = CGSize(width: 0, height: 5)
        bgView.layer.shadowOpacity = 0.1
        bgView.layer.shadowRadius = 5
    }
    
}
