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
    
    var links: [ExternalLink]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setUpTableView()
    }
    
    func setUpTableView() {
        self.externalLinkTableView.delegate = self
        self.externalLinkTableView.dataSource = self
        self.externalLinkTableView.register(ExternalLinkCell.nib, forCellReuseIdentifier: ExternalLinkCell.identifier)
    }
    
    func setUpCell(links: [ExternalLink]?) {
        if let links = links {
            self.links = links
            self.tableViewHeightContraint.constant = CGFloat(50 * links.count)
            self.externalLinkTableView.reloadData()
        }
    }
}

extension AnimeStatsCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let links = self.links {
            return links.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ExternalLinkCell.identifier) as? ExternalLinkCell {
            cell.setUpCell(link: self.links![indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
}
