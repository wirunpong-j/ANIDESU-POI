//
//  AnimeDetailViewController.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 22/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AnimeDetailViewController: BaseViewController {
    static let identifier = "AnimeDetailViewController"
    
    @IBOutlet weak var animeDetailTableView: UITableView!
    @IBOutlet weak var animeBannerImage: UIImageView!
    
    var discoverAnimeViewModel: DiscoverAnimeViewModel!
    var disposeBag = DisposeBag()
    var anime: Anime?
    
    private enum AnimeDetailSections: Int {
        case detail, info, stats, extras
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
        self.animeDetailTableView.register(AnimeStatsCell.nib, forCellReuseIdentifier: AnimeStatsCell.identifier)
        self.animeDetailTableView.register(AnimeExtrasCell.nib, forCellReuseIdentifier: AnimeExtrasCell.identifier)
    }
    
    private func setUpViewModel() {
        self.discoverAnimeViewModel = DiscoverAnimeViewModel()
        
        self.discoverAnimeViewModel.errorRelay.subscribe(onNext: { (errorString) in
            self.showAlert(title: "Error", message: errorString)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
    }
    
    private func setUpView() {
        self.title = self.anime?.titleRomaji!
        
        if let bannerImage = self.anime?.imageUrlBanner {
            self.animeBannerImage.setImage(urlStr: bannerImage)
        } else {
            self.animeBannerImage.setImage(urlStr: (self.anime?.imageUrlLarge)!)
        }
        
        self.discoverAnimeViewModel.fetchAnimePage(animeID: (self.anime?.id)!) { (anime) in
            self.anime = anime
            self.animeDetailTableView.reloadData()
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AnimeDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch AnimeDetailSections(rawValue: indexPath.section)! {
        case .detail:
            if let cell = tableView.dequeueReusableCell(withIdentifier: AnimeHeaderCell.identifier) as? AnimeHeaderCell {
                cell.setUpCell(anime: self.anime!)
                return cell
            }
        case .info:
            if let cell = tableView.dequeueReusableCell(withIdentifier: AnimeInfoCell.identifier) as? AnimeInfoCell {
                cell.setUpCell(anime: self.anime!)
                return cell
            }
        case .stats:
            if let cell = tableView.dequeueReusableCell(withIdentifier: AnimeStatsCell.identifier) as? AnimeStatsCell {
                cell.setUpCell(links: self.anime?.externalLinks)
                return cell
            }
        case .extras:
            if let cell = tableView.dequeueReusableCell(withIdentifier: AnimeExtrasCell.identifier) as? AnimeExtrasCell {
                cell.setUpCell(characters: self.anime?.characters, staffs: self.anime?.staff)
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch AnimeDetailSections(rawValue: section)! {
        case .info:
            return SectionHeaderView.loadViewFromNib(title: "Info", backgroundColor: AnidesuColor.DarkBlue)
        case .stats:
            return SectionHeaderView.loadViewFromNib(title: "Stats", backgroundColor: AnidesuColor.DarkBlue)
        case .extras:
            return SectionHeaderView.loadViewFromNib(title: "Extras", backgroundColor: AnidesuColor.DarkBlue)
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch AnimeDetailSections(rawValue: section)! {
        case .info, .stats, .extras:
            return 50
        default:
            return 0
        }
    }
}
