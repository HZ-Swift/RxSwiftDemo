//
//  RxViewController.swift
//  RxSwiftDemo
//
//  Created by Harious on 2018/2/1.
//  Copyright © 2018年 enetic. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxViewController: UIViewController {
    
    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
    }

    deinit {
        print(NSStringFromClass(self.classForCoder), "  😝 😝 😝 😝 deinit")
    }

}
