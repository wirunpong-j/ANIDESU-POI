//
//  MyAnimeListCell.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 27/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

class MyAnimeListCell: UICollectionViewCell {
    static let nib = UINib(nibName: "MyAnimeListCell", bundle: .main)
    static let identifier = "MyAnimeListCell"
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var animeTitleLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpCell(myAnimeList: MyAnimeList) {
        self.coverImage.setImage(urlStr: (myAnimeList.anime?.imageUrlLarge)!)
        self.animeTitleLabel.text = (myAnimeList.anime?.titleRomaji)!
        self.progressLabel.text = "EP: \(myAnimeList.progress)/\((myAnimeList.anime?.totalEP)!)"
        self.scoreLabel.text = "Score: \(myAnimeList.score)/10"
    }

}
