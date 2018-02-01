//
//  TableViewController__1.swift
//  RxSwiftDemo
//
//  Created by 郑章海 on 2018/2/1.
//  Copyright © 2018年 enetic. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources
import RxCocoa


class TableViewController__1: RxViewController {
    
    var tableView: UITableView!
    
//    lazy var tableView: UITableView = {
//        let table = UITableView(frame: CGRect.zero, style: .plain)
//        table.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
//        return table
//    }()
    
    lazy var dataSource = {
        
        return Observable.just([SectionModel(model: "A", items: [[TablePerson(name: "xiaohai", age: 15),
                                                                  TablePerson(name: "damin", age: 14),
                                                                  TablePerson(name: "hahah", age: 20),
                                                                  TablePerson(name: "hohohohoh", age: 19),
                                                                  TablePerson(name: "mini", age: 15),
                                                                  TablePerson(name: "sdfsdfds", age: 45),
                                                                  TablePerson(name: "dahai", age: 100),
                                                                  TablePerson(name: "mmmm", age: 88)]])])
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.frame = view.bounds

        let rxDataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, TableModel>>(configureCell:
            { _ , tableView, indexPath, model in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
                cell?.textLabel?.text = model.name
                return cell!
        })
        
        
//        dataSource.asDriver(onErrorJustReturn: []).drive(tableView.rx.items(dataSource: rxDataSource))
//        dataSource.asDriver(onErrorJustReturn: [])
//            .drive(tableView.rx.items(dataSource: rxDataSource))
//            .disposed(by: disposeBag)
//        dataSource.asDriver(onErrorJustReturn: [])
//            .drive(tableView.rx.items(dataSource: rxDataSource))
//            .disposed(by: disposeBag)
        
    }
}



class TableModel {
    var name: String
    var age: Int
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

extension TableModel: IdentifiableType {
    var identity: String {
        return name
    }
    
    typealias Identity = String
    
}
