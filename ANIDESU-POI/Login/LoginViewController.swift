//
//  LoginViewController.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 6/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import FirebaseAuth
import RxCocoa
import RxSwift
import IHKeyboardAvoiding

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var viewModel: MyAccountViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidAppear(_ animated: Bool) {
//        try! Auth.auth().signOut()
        self.setUpViewModel()
        self.setUpView()
    }
    
    private func setUpViewModel() {
        self.viewModel = MyAccountViewModel()
        
        self.viewModel.errorRelay.subscribe(onNext: { (errorString) in
            self.showAlert(title: "Error", message: errorString)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
        
        self.viewModel.isLoading.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showLoading()
            } else {
                self.hideLoading()
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
        
        self.viewModel.getCurrentUser { (isCurrent) in
            if isCurrent {
                self.showMainStoryboard()
            }
        }
    }
    
    private func setUpView() {
        KeyboardAvoiding.avoidingView = self.emailTextField
        self.emailTextField.text = ""
        self.passwordTextField.text = ""
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        self.viewModel.login(email: email, password: password) {
            self.showMainStoryboard()
        }
    }
    
    @IBAction func registerBtnPressed(_ sender: Any) {
        self.performSegue(withIdentifier: RegisterViewController.identifier, sender: nil)
    }
    
    private func showMainStoryboard() {
        let storyboard = UIStoryboard(name: AnidesuStoryboard.Main.name, bundle: nil)
        let vc = storyboard.instantiateInitialViewController()!
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
