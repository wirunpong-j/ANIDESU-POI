//
//  BaseViewController.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 6/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

public enum AnidesuStoryboard {
    case Login
    case Main
    case Register
    
    func getName() -> String {
        switch self {
        case .Login: return "Login"
        case .Main: return "Main"
        case .Register: return "Register"
        }
    }
}

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showStoryboard(storyboardName: AnidesuStoryboard) {
        let storyboard = UIStoryboard(name: storyboardName.getName(), bundle: nil)
        var vc: UIViewController!
        
        switch storyboardName {
        case .Login:
            vc = storyboard.instantiateInitialViewController()! as! LoginViewController
        case .Main:
             break
        case .Register:
            break
        }
        
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func showAlert(title: String, message: String, with handler: @escaping (()->()) ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction((UIAlertAction(title: "Ok", style: .default, handler: { (_) in
            handler()
        })))
        self.present(alert, animated: true)
    }

}
