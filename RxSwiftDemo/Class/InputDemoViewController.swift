//
//  InputDemoViewController.swift
//  RxSwiftDemo
//
//  Created by Harious on 2018/1/31.
//  Copyright © 2018年 enetic. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class InputDemoViewController: UIViewController {

    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var nameInputTF: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    var nameArray: Variable<[String]> = Variable([])
    
    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bind()
        self.bindSubmitBtn()
    }

    fileprivate func bind() {
        nameInputTF.rx.text
            .map { text in
                if text == nil || text == "" {
                    return "hello，请输入"
                } else {
                    return "hello，\(text!)"
                }
        }
            .bind(to: helloLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    fileprivate func bindSubmitBtn() {
        Reactive
        submitBtn.rx
        submitBtn.rx.tap.subscribe (onNext: {
            print("sdkfhkj")
            if self.nameInputTF.text == nil && self.nameInputTF.text != "" {
                self.nameArray.value.append(self.nameInputTF.text!)
                self.nameLabel.text = self.nameArray.value.joined(separator: ",")
                self.nameInputTF.text = ""
            }
        }).disposed(by: disposeBag)
    }

}
