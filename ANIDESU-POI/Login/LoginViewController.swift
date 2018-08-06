//
//  LoginViewController.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 6/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var loginViewModel: LoginViewModel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewModel()
    }
    
    func setViewModel() {
        self.loginViewModel = LoginViewModel()
    }
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        self.loginViewModel.login(email: email, password: password) { (error) in
            if let error = error {
                self.showAlert(title: "ERROR", message: error.localizedDescription)
            } else {
                self.showAlert(title: "SUCCESS", message: "Login Successful.")
            }
        }
    }
    
    @IBAction func registerBtnPressed(_ sender: Any) {
        
    }
}
