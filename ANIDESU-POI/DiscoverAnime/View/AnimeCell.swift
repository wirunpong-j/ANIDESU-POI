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
    
    func setUpView(anime: AnimeResponse) {
        animeImg.setImage(urlStr: anime.image_url_lge!)
        animeTitleLabel.text = anime.title_romaji!
        seriesTypeLabel.text = anime.series_type!.uppercased()
        airingStatusLabel.text = anime.airing_status!.uppercased()
        avgLabel.text = "⭐️ \(anime.average_score!)"
    }

}
