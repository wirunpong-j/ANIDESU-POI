//
//  CreateReviewViewController.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 31/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import Cosmos
import RxCocoa
import RxSwift
import IHKeyboardAvoiding

class CreateReviewViewController: BaseViewController {
    static let identifier = "CreateReviewViewController"

    @IBOutlet weak var animeNameLabel: UILabel!
    @IBOutlet weak var animeBannerImage: UIImageView!
    @IBOutlet weak var ratingBar: CosmosView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    
    var review: Review?
    var anime: Anime?
    var viewModel: ReviewViewModel!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViewModel()
    }
    
    private func setUpViewModel() {
        self.viewModel = ReviewViewModel()
        
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
        
        self.viewModel.fetchReviewPage(animeID: (self.anime?.id)!) { (review) in
            self.review = review
            self.setUpView()
        }
    }
    
    private func setUpView() {
        KeyboardAvoiding.avoidingView = self.view
        self.navigationController?.navigationBar.tintColor = AnidesuColor.White.color()
        self.title = "Review"
        self.animeNameLabel.text = "Review: " + (self.anime?.titleRomaji)!
        self.animeBannerImage.setImage(urlStr: (self.anime?.imageUrlLarge)!)
        self.titleTextField.text = self.review == nil ? "" : self.review?.title
        self.reviewTextView.text = self.review == nil ? "" : self.review?.desc
        self.ratingBar.rating = self.review == nil ? 0 : (self.review?.rating)!
    }

    @IBAction func saveBtnPressed(_ sender: Any) {
        if let titleText = titleTextField.text, !(titleTextField.text?.isEmpty)! {
            let reviewText = self.reviewTextView.text ?? ""
            let rating = self.ratingBar.rating
            let key = self.review?.key ?? ""
            
            self.viewModel.updateReviewAnime(key: key, animeID: (anime?.id)!, title: titleText, desc: reviewText, rating: rating, reviewDate: AnidesuConverter.getCurrentTime(), uid: MyProfileModel.instance.uid) {
                self.navigationController?.popViewController(animated: true)
            }
        
        } else {
            self.showAlert(title: "Error", message: "Please fill title.")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
