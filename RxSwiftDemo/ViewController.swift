//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by 郑章海 on 2018/1/10.
//  Copyright © 2018年 enetic. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let numbeSqueue = Observable.just(33)
        let scpirtion = numbeSqueue.subscribe { (index) in
            print(index)
        }
        scpirtion.dispose()

        let helloSqueue = Observable.from(["H", "E", "L", "L", "0"])
        let helloScription = helloSqueue.subscribe { (event) in
            switch event {
            case .next(let value):
                print(value)
            case .error(let error):
                print(error)
            case .completed:
                print("ok")
            }
        }
        helloScription.dispose()
    }


}

