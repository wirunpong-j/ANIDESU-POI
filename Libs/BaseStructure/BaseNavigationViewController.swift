//
//  BaseNavigationViewController.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 7/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import Hero

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hero.isEnabled = true
        self.setUpNavBar()
    }
    
    func setUpNavBar() {
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: AnidesuColor.White.color()]
        self.navigationItem.backBarButtonItem?.tintColor = AnidesuColor.White.color()
        self.setUpProfileImage()
    }
    
    func setUpProfileImage() {
        let containView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        image.setImageWithRounded(urlStr: MyProfileModel.instance.imageUrlProfile, borderColor: AnidesuColor.White)
        image.hero.id = "profileImage"
        containView.addSubview(image)
        containView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.profileImageAction(sender:))))
        let rightBarButton = UIBarButtonItem(customView: containView)
        self.navigationBar.topItem?.rightBarButtonItem = rightBarButton
    }
    
    @objc func profileImageAction(sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: AnidesuStoryboard.MyProfile.name, bundle: nil)
        let vc = storyboard.instantiateInitialViewController()!
        vc.hero.isEnabled = true
        vc.hero.modalAnimationType = .selectBy(presenting: .zoom, dismissing: .zoomOut)
        self.present(vc, animated: true)
    }
}
