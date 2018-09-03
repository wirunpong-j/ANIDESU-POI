//
//  BaseNavigationViewController.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 7/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
        containView.addSubview(image)
        containView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.profileImageAction(sender:))))
        let rightBarButton = UIBarButtonItem(customView: containView)
        self.navigationBar.topItem?.rightBarButtonItem = rightBarButton
    }
    
    @objc func profileImageAction(sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: AnidesuStoryboard.MyProfile.name, bundle: nil)
        let vc = storyboard.instantiateInitialViewController()!
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
