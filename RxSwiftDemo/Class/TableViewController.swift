//
//  TableViewController.swift
//  RxSwiftDemo
//
//  Created by Harious on 2018/2/1.
//  Copyright © 2018年 enetic. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class TableViewController: RxViewController {
    

    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .plain)
        table.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
        return table
    }()
    
    lazy var dataSource = {
        Observable.of([TablePerson(name: "xiaohai", age: 15),
                       TablePerson(name: "damin", age: 14),
                       TablePerson(name: "hahah", age: 20),
                       TablePerson(name: "hohohohoh", age: 19),
                       TablePerson(name: "mini", age: 15),
                       TablePerson(name: "sdfsdfds", age: 45),
                       TablePerson(name: "dahai", age: 100),
                       TablePerson(name: "mmmm", age: 88)])
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        
        dataSource.asDriver(onErrorJustReturn: []).drive(tableView.rx.items(cellIdentifier: "Cell")){_ , person, cell in
            cell.textLabel?.text = person.name
            cell.detailTextLabel?.text = String(person.age)
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(TablePerson.self).subscribe(onNext: {
            print($0)
        }).disposed(by: disposeBag)
        
    }


}


class TablePerson {
    var name: String
    var age: Int
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}
