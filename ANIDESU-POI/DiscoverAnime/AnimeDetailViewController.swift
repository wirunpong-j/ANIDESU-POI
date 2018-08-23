//
//  AnimeDetailViewController.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 22/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

class AnimeDetailViewController: BaseViewController {
    static let identifier = "AnimeDetailViewController"
    
    @IBOutlet weak var animeDetailTableView: UITableView!
    
    private enum AnimeDetailSections: Int {
        case detail, info
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTableView()
        self.setUpViewModel()
        self.setUpView()
    }
    
    private func setUpTableView() {
        self.animeDetailTableView.delegate = self
        self.animeDetailTableView.dataSource = self
        self.animeDetailTableView.register(AnimeHeaderCell.nib, forCellReuseIdentifier: AnimeHeaderCell.identifier)
        self.animeDetailTableView.register(AnimeInfoCell.nib, forCellReuseIdentifier: AnimeInfoCell.identifier)
    }
    
    private func setUpViewModel() {
        
    }
    
    private func setUpView() {
        
    }
}

extension AnimeDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch AnimeDetailSections(rawValue: indexPath.section)! {
        case .detail:
            if let cell = tableView.dequeueReusableCell(withIdentifier: AnimeHeaderCell.identifier) as? AnimeHeaderCell {
                return cell
            }
        case .info:
            if let cell = tableView.dequeueReusableCell(withIdentifier: AnimeInfoCell.identifier) as? AnimeInfoCell {
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch AnimeDetailSections(rawValue: section)! {
        case .info:
            return SectionHeaderView.loadViewFromNib(title: "Info", backgroundColor: AnidesuColor.DarkBlue)
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch AnimeDetailSections(rawValue: section)! {
        case .info:
            return 50
        default:
            return 0
        }
    }
}
