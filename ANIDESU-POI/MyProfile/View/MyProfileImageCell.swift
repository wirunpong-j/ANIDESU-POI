//
//  MyProfileImageCell.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 3/9/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

class MyProfileImageCell: UITableViewCell {
    static let nib = UINib(nibName: "MyProfileImageCell", bundle: .main)
    static let identifier = "MyProfileImageCell"

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpCell()
    }

    private func setUpCell() {
        self.profileImage.setImageWithRounded(urlStr: MyProfileModel.instance.imageUrlProfile, borderColor: AnidesuColor.White)
        self.displayNameLabel.text = MyProfileModel.instance.displayName
    }

}
