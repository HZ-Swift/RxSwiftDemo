//
//  ObserverViewController.swift
//  RxSwiftDemo
//
//  Created by Harious on 2018/2/1.
//  Copyright © 2018年 enetic. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ObserverViewController: RxViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
                
//        neverDemo()
        
//        emptyDemo()
        
//        justDemo()
        
//        ofDemo()
        
//        fromDemo()
        
//        errorDemo()
        
        createDemo()
    }
    
    
    /// 创建一个不会发送任何内容的观察者
    func neverDemo() {
        
        let neverSequence = Observable<String>.never()
        
        neverSequence.subscribe { (event) in
            print("永远不会执行")
        }.disposed(by: disposeBag)
    }
    
    /// 不会通知信号的内容，只会告诉完成（completed）
    func emptyDemo() {
        
        Observable<Int>.empty().subscribe { (event) in
            print(event)
        }.disposed(by: disposeBag)
        
    }
    
    /// just把一个或多个对象换成这个或这些对象的observable，会先发送next，再发送completed
    func justDemo() {
        
        let observable = Observable.just("2345")
        
        observable.subscribe { (event) in
            print(event)
        }.disposed(by: disposeBag)
        
    }
    
    func ofDemo() {
        
        let observable = Observable.of(1, 2, 3)
        
        observable.subscribe { (event) in
            print(event)
        }.disposed(by: disposeBag)
        
//        observable.subscribe { (event) in
//            switch event {
//            case .next(let value): print(value)
//            case .error(let error): print(error)
//            case .completed: print("完成")
//            }
//        }.disposed(by: disposeBag)
        
        
//        Observable.of(5,6).subscribe(
//            onNext: { print($0) },
//            onError : { print($0) },
//            onCompleted: { print("完成") },
//            onDisposed: { print("disposed") }
//        ).disposed(by: disposeBag)
        
    }
    
    /// 把系列转换成事件序列(把传进来的这个数组的每个元素都当成一个事件,如果数组中又嵌套，只会解析到数组的第一层)
    func fromDemo() {
        
        let observable = Observable.from([[1, 2, 3], 1])
        observable.subscribe { (event) in
            print(event)
        }.disposed(by: disposeBag)
//        next([1, 2, 3])
//        next(1)
//        completed
    }
    
    
    
    func errorDemo() {
        
        enum MyError: Error {
            case test
        }
        
        Observable<Void>.error(MyError.test).subscribe(
            onError : { print($0) }
        ).disposed(by: disposeBag)
    }
    
    
    //MARK: --------------- 下面的都是一些比较冷门的 ------------------ 这里还有些东西没完。。。。。。
    func createDemo() {
        let myCreate = { (element: String) -> Observable<String> in
            return Observable<String>.create({ (observable) -> Disposable in
                
                observable.on(.next(element))
                observable.on(.completed)
                
                return Disposables.create()
                
            })
        }
        
        myCreate("HH").subscribe({
            print($0)
        }).disposed(by: disposeBag)
    }

}











