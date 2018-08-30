//
//  CreateMyAnimeListViewController.swift
//  ANIDESU-POI
//
//  Created by Wirunpong Jaingamlertwong on 29/8/2561 BE.
//  Copyright © 2561 Wirunpong Jaingamlertwong. All rights reserved.
//

import UIKit
import Eureka
import RxCocoa
import RxSwift

class CreateMyAnimeListViewController: FormViewController {
    static let identifier = "CreateMyAnimeListViewController"
    
    @IBOutlet weak var cancelBtn: UIBarButtonItem!
    @IBOutlet weak var addBtn: UIBarButtonItem!
    
    var anime: Anime?
    var viewModel: MyAnimeListViewModel!
    var disposeBag = DisposeBag()
    
    let ALL_STATUS = [MyAnimeListStatus.PlanToWatch.rawValue.capitalized,
                      MyAnimeListStatus.Watching.rawValue.capitalized,
                      MyAnimeListStatus.Completed.rawValue.capitalized,
                      MyAnimeListStatus.Dropped.rawValue.capitalized]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViewModel()
        self.setUpView()
    }
    
    private func setUpViewModel() {
        self.viewModel = MyAnimeListViewModel()
        
        self.viewModel.errorRelay.subscribe(onNext: { (errorString) in
            print("Error :" + errorString)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposeBag)
    }
    
    private func setUpView() {
        self.title = "Add " + (anime?.titleRomaji)!
        self.setUpForm()
    }
    
    private func setUpForm() {
        form +++ Section("Add to My Anime List *")
            <<< PickerInputRow<String>() {
                $0.tag = "status"
                $0.title = "Status"
                $0.options = ALL_STATUS
                $0.value = ALL_STATUS[0]
            }
            <<< PickerInputRow<Int>() {
                $0.tag = "progress"
                $0.title = "Progress (EP)"
                $0.options = Array(0...(anime?.totalEP)!)
                $0.value = 0
            }
            <<< PickerInputRow<Int>() {
                $0.tag = "score"
                $0.title = "Score"
                $0.options = Array(0...10)
                $0.value = 0
            }
            +++ Section("Notes (Optional)")
            <<< TextAreaRow() {
                $0.tag = "notes"
                $0.placeholder = "Write your notes..."
                $0.value = ""
            }
            +++ Section()
            <<< ButtonRow ("Delete") {
                $0.title = "Delete"
                }.cellUpdate { cell, row in
//                    cell.isHidden = !(self.myAnimeList?.isAdded)!
//                    cell.textLabel?.textColor = UIColor.red
                }.onCellSelection { cell, row in
//                    let alert = UIAlertController(title: "Alert", message: "Are you sure you want to remove this form your list ?", preferredStyle: UIAlertControllerStyle.alert)
//                    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
//                        self.removeThisAnimeFormList()
//                    }))
//                    alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
//                    self.present(alert, animated: true, completion: nil)
        }
        
//        if (myAnimeList?.isAdded)! {
//            navigationItem.title = "Edit: \((myAnimeList?.anime?.title_romaji)!)"
//        } else {
//            navigationItem.title = "Add: \((myAnimeList?.anime?.title_romaji)!)"
//        }
        navigationOptions = RowNavigationOptions.Enabled.union(.StopDisabledRow)
        animateScroll = true
        rowKeyboardSpacing = 20
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        let result = form.values()
        let status = result["status"] as? String ?? ""
        let progress = result["progress"] as? Int ?? 0
        let score = result["score"] as? Int ?? 0
        let note = result["notes"] as? String ?? ""
        
        let newList = MyAnimeList(animeID: (anime?.id)!, note: note, status: status.lowercased(), progress: progress, score: score)
        
        self.viewModel.addToMyAnimeList(myAnimeList: newList) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
