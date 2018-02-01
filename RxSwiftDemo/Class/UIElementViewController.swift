//
//  UIElementViewController.swift
//  RxSwiftDemo
//
//  Created by Harious on 2018/2/1.
//  Copyright © 2018年 enetic. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UIElementViewController: RxViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    let nameTFText = Variable("")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTF.rx.text.orEmpty.bind(to: nameTFText).disposed(by: disposeBag)
//        nameTFText.asObservable().subscribe(onNext: {
//            print($0, "ddd")
//        }).disposed(by: disposeBag)
        
        nameTFText.asObservable().map { _ in return "sss" }.subscribe(onNext: {
            print($0, "ddd")
        }).disposed(by: disposeBag)
        
        loginBtn.rx.tap.subscribe (onNext: { [unowned self] in
            self.view.endEditing(true)
        }).disposed(by: disposeBag)
        loginBtn.rx.tap
            .map{ [unowned self] in
                self.nameTF.text!.count > 3 ? true : false
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }

}
