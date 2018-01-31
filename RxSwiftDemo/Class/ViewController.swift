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
    
    fileprivate var cellTitles: [String] {
        return ["一些基本的用法", "类似登录页面的Demo"]
    }
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "UITableViewCell")
        return tableView
    }()
    
    fileprivate func cellViewController(_ title: String) -> UIViewController {
        
        var vc : UIViewController! = nil
        
        switch title {
        case "一些基本的用法": vc = GrammarAndUsageViewController()
        case "类似登录页面的Demo": vc = InputDemoViewController()
        default:            vc = UIViewController()
        }
        
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = cellTitles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title = cellTitles[indexPath.row]
        
        let vc = cellViewController(title)
        vc.navigationItem.title = title
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let numbeSqueue = Observable.just(33)
//        let scpirtion = numbeSqueue.subscribe { (index) in
//            print(index)
//        }
//        scpirtion.dispose()
//
//        let helloSqueue = Observable.from(["H", "E", "L", "L", "0"])
//        let helloScription = helloSqueue.subscribe { (event) in
//            switch event {
//            case .next(let value):
//                print(value)
//            case .error(let error):
//                print(error)
//            case .completed:
//                print("ok")
//            }
//        }
//        helloScription.dispose()
//    }
//
//
//}

