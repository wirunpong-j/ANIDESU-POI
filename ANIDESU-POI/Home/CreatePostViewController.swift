//
//  CreatePostViewController.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 20/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit

class CreatePostViewController: BaseViewController {
    static let identifier = "CreatePostViewController"
    
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTapGestureRecognizer()
        self.setUpView()
    }
    
    private func setUpView() {
        messageTextView.delegate = self
        profileImage.setImageWithRounded(urlStr: UserDataModel.instance.image_url_profile, borderColor: AnidesuColor.Clear)
        displayNameLabel.text = UserDataModel.instance.display_name
        aboutLabel.text = UserDataModel.instance.about
    }
    
    private func setTapGestureRecognizer() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func shareBtnPressed(_ sender: Any) {
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
    }
}

extension CreatePostViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            shareBtn.isEnabled = false
        } else {
            shareBtn.isEnabled = true
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "What's on your mind?" {
            textView.text = ""
            textView.textColor = AnidesuColor.DarkBlue.color()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "What's on your mind?"
            textView.textColor = AnidesuColor.DarkGray.color()
        }
    }
}
