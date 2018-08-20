//
//  PrePostCell.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 20/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

class PrePostCell: UITableViewCell {
    static let nib = UINib(nibName: "PrePostCell", bundle: .main)
    static let identifier = "PrePostCell"
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpView()
    }
    
    func setUpView() {
        profileImage.setImageWithRounded(urlStr: UserDataModel.instance.image_url_profile, borderColor: AnidesuColor.Clear)
        displayNameLabel.text = UserDataModel.instance.display_name
        aboutLabel.text = UserDataModel.instance.about
        self.setBorderView()
    }
    
    func setBorderView() {
        bgView.layer.shadowColor = AnidesuColor.Black.color().cgColor
        bgView.layer.shadowOffset = CGSize(width: 0, height: 5)
        bgView.layer.shadowOpacity = 0.1
        bgView.layer.shadowRadius = 5
    }

}
