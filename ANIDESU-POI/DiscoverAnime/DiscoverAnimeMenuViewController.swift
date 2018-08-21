//
//  DiscoverAnimeMenuViewController
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 19/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import Tabman
import Pageboy
import RxSwift
import RxCocoa

class DiscoverAnimeMenuViewController: TabmanViewController, PageboyViewControllerDataSource {
    
    var menus = [UIViewController]()
    let ALL_SEASON = [AnimeSeason.Winter, AnimeSeason.Spring, AnimeSeason.Fall, AnimeSeason.Summer]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }
    
    func setUpView() {
        self.dataSource = self
        self.bar.items = [Item(title: ALL_SEASON[0].rawValue.uppercased()),
                          Item(title: ALL_SEASON[1].rawValue.uppercased()),
                          Item(title: ALL_SEASON[2].rawValue.uppercased()),
                          Item(title: ALL_SEASON[3].rawValue.uppercased())]
        self.bar.style = .scrollingButtonBar
        self.bar.appearance = TabmanBar.Appearance({ (appearance) in
            // customize appearance here
            appearance.state.selectedColor = AnidesuColor.Green.color()
            appearance.state.color = AnidesuColor.White.color()
            appearance.indicator.color = AnidesuColor.Green.color()
            appearance.indicator.lineWeight = .thick
            appearance.style.background = .solid(color: AnidesuColor.DarkBlue.color())
            appearance.text.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
            appearance.layout.minimumItemWidth = 100
        })
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1336890757, green: 0.1912626624, blue: 0.2462295294, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        tabBarController?.tabBar.backgroundColor = #colorLiteral(red: 0.1336890757, green: 0.1912626624, blue: 0.2462295294, alpha: 1)
        
        for season in ALL_SEASON {
            let discoverAnimeViewController = self.setDiscoverAnimeViewController(animeSeason: season)
            self.menus.append(discoverAnimeViewController)
        }
        
        self.reloadPages()
    }
    
    private func setDiscoverAnimeViewController(animeSeason: AnimeSeason) -> UIViewController {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: DiscoverAnimeViewController.identifier) as? DiscoverAnimeViewController
        viewController?.animeSeason = animeSeason
        return viewController!
    }

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return self.menus.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return self.menus[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }

}
