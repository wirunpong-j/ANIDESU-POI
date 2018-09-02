//
//  AnimeCell.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 19/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

class AnimeCell: UICollectionViewCell {
    static let nib = UINib(nibName: "AnimeCell", bundle: .main)
    static let identifier = "AnimeCell"
    
    @IBOutlet weak var animeImg: UIImageView!
    @IBOutlet weak var animeTitleLabel: UILabel!
    @IBOutlet weak var seriesTypeLabel: UILabel!
    @IBOutlet weak var airingStatusLabel: UILabel!
    @IBOutlet weak var avgLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpView(anime: Anime) {
        animeImg.setImage(urlStr: anime.imageUrlLarge)
        animeTitleLabel.text = anime.titleRomaji
        seriesTypeLabel.text = anime.seriesType.uppercased()
        airingStatusLabel.text = anime.airingStatus.uppercased()
        avgLabel.text = "⭐️ \(anime.averageScore)"
    }

}
