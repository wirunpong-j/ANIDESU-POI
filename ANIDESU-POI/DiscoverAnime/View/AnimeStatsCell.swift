//
//  AnimeStatsCell.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 23/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

class AnimeStatsCell: UITableViewCell {
    static let nib = UINib(nibName: "AnimeStatsCell", bundle: .main)
    static let identifier = "AnimeStatsCell"

    @IBOutlet weak var externalLinkTableView: UITableView!
    @IBOutlet weak var completedLabel: UILabel!
    @IBOutlet weak var planToWatchLabel: UILabel!
    @IBOutlet weak var droppedByLabel: UILabel!
    @IBOutlet weak var watchingLabel: UILabel!
    
    @IBOutlet weak var tableViewHeightContraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpTableView()
    }
    
    func setUpTableView() {
        self.externalLinkTableView.delegate = self
        self.externalLinkTableView.dataSource = self
        self.externalLinkTableView.register(ExternalLinkCell.nib, forCellReuseIdentifier: ExternalLinkCell.identifier)
    }
    
    func setUpCell() {
        self.tableViewHeightContraint.constant = 50 * 3
    }
}

extension AnimeStatsCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ExternalLinkCell.identifier) as? ExternalLinkCell {
            return cell
        }
        
        return UITableViewCell()
    }
}
