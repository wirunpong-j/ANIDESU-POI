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

class MenuViewController: TabmanViewController, PageboyViewControllerDataSource {
    
    var menus = [UIViewController]()
    let ALL_SEASON = [AnimeSeason.Winter, AnimeSeason.Spring, AnimeSeason.Fall, AnimeSeason.Summer]
    let ALL_STATUS = [MyAnimeListStatus.PlanToWatch, MyAnimeListStatus.Watching, MyAnimeListStatus.Completed, MyAnimeListStatus.Dropped]
    let discoverAnimeMenuIdentifier = "DiscoverAnimeMenuViewController"
    let myAnimeListMenuIdentifier = "MyAnimeListMenuViewController"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }
    
    func setUpView() {
        self.dataSource = self
        self.bar.items = self.setMenuItems()
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
        
        self.navigationController?.navigationBar.barTintColor = AnidesuColor.MiddleDarkBlue.color()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.tabBarController?.tabBar.backgroundColor = AnidesuColor.MiddleDarkBlue.color()
        self.setViewController()
        self.reloadPages()
    }
    
    private func setMenuItems() -> [TabmanBar.Item]? {
        switch self.restorationIdentifier {
        case discoverAnimeMenuIdentifier:
            return [Item(title: ALL_SEASON[0].rawValue.uppercased()),
                    Item(title: ALL_SEASON[1].rawValue.uppercased()),
                    Item(title: ALL_SEASON[2].rawValue.uppercased()),
                    Item(title: ALL_SEASON[3].rawValue.uppercased())]
        case myAnimeListMenuIdentifier:
            return [Item(title: ALL_STATUS[0].rawValue.uppercased()),
                    Item(title: ALL_STATUS[1].rawValue.uppercased()),
                    Item(title: ALL_STATUS[2].rawValue.uppercased()),
                    Item(title: ALL_STATUS[3].rawValue.uppercased())]
        default:
            return nil
        }
    }
    
    private func setViewController() {
        switch self.restorationIdentifier {
        case discoverAnimeMenuIdentifier:
            for season in ALL_SEASON {
                let viewController = self.storyboard?.instantiateViewController(withIdentifier: DiscoverAnimeViewController.identifier) as? DiscoverAnimeViewController
                viewController?.animeSeason = season
                self.menus.append(viewController!)
            }
        case myAnimeListMenuIdentifier:
            for myAnimeListStatus in ALL_STATUS {
                let viewController = self.storyboard?.instantiateViewController(withIdentifier: MyAnimeListViewController.identifier) as? MyAnimeListViewController
                viewController?.myAnimeListStatus = myAnimeListStatus
                self.menus.append(viewController!)
            }
        default:
            break
        }
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
