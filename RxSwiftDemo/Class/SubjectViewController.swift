//
//  SubjectViewController.swift
//  RxSwiftDemo
//
//  Created by Harious on 2018/2/1.
//  Copyright © 2018年 enetic. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SubjectViewController: RxViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        publishDemo()
        
//        replayDemo()
        
//        behaviorDemo()
        
        variableDemo()
    }
    
    func writeSequenceToConsole<O: ObservableType>(name: String, sequence: O) -> Disposable{
        return sequence.subscribe({ (event) in
            print("Subscription: ", name, "Event: ", "\(event)")
        })
    }
    
    /// PublishSubject 只会接收来订阅后发送出来的消息
    func publishDemo() {
        let publishObject = PublishSubject<String>()
        
        publishObject.onNext("0")
        publishObject.onNext("1")
        
        publishObject.addObservable("NO 1").disposed(by: disposeBag)
        
        publishObject.onNext("2")
        publishObject.onNext("3")
        
        publishObject.addObservable("NO 2").disposed(by: DisposeBag()/* mark */)
        
        publishObject.onNext("A")
        publishObject.onNext("B")
        
        // 第一个订阅者 NO 1 收到2 3  A B（只能这个这个订阅者订阅后发来的消息）
        // 非第一个订阅者 No 2 : 如果mark处使用第一个订阅者的disposeBag,收到 A B (跟第一个订阅者规则一样);如果mark处使用DisposeBag()，收不到任何消息
    }
    
    /// ReplaySubject 订阅后发送的信号都可收到，但订阅前的信号受bufferSize数量限制
    func replayDemo() {
        
        print("-------------------------------------------------------")
        
        let replaySubject = ReplaySubject<String>.create(bufferSize: 2)
        
        replaySubject.onNext("-3")
        replaySubject.onNext("-2")
        replaySubject.onNext("-1")
        
        replaySubject.addObservable("No 1").disposed(by: disposeBag)
        
        replaySubject.onNext("1")
        replaySubject.onNext("2")
        replaySubject.onNext("3")
        
        replaySubject.addObservable("No 6").disposed(by: disposeBag /* mark */)
        
        replaySubject.onNext("4")
        replaySubject.onNext("5")
        replaySubject.onNext("6")
        
        // 第一个订阅者 No 1 收到 -2 -1 1 2 3 4 5 6 （该订阅者能收到订阅前最后限制数量的消息，和订阅后的所有消息）
        // 非第一个订阅者 No 6 : 如果mark处使用第一个订阅者的disposeBag,收到2 3 4 5 6 (跟第一个订阅者规则一样);如果mark处使用DisposeBag()，收到2 3(只能收到订阅前的z最后限制数量的消息)
    }
    
    func behaviorDemo() {
        
        print("-------------------------------------------------------")
        
        let behaviorSubject = BehaviorSubject(value: "behavior")
        
        behaviorSubject.onNext("-1")
        behaviorSubject.onNext("0")
        
        behaviorSubject.addObservable("No 1").disposed(by: disposeBag)
        
        behaviorSubject.onNext("1")
        behaviorSubject.onNext("2")
        behaviorSubject.onNext("3")
        behaviorSubject.onNext("4")
        
        behaviorSubject.addObservable("No 6").disposed(by: disposeBag /* mark */)
        
        behaviorSubject.onNext("5")
        behaviorSubject.onNext("6")
        behaviorSubject.onNext("7")
        
        // 第一个订阅者 No 1 收到 0 1 2 3 4 5 6 7（该订阅者能收到订阅前最后一条消息，和订阅后的所有消息）
        // 非第一个订阅者 No 6 : 如果mark处使用第一个订阅者的disposeBag,收到4 5 6 7(跟第一个订阅者规则一样);如果mark处使用DisposeBag()，收到4(只能收到订阅前的最后一个消息)
    }
    
    // BehaviorSubject 的进一层封装, 与BehaviorSubject区别(订阅完成后会一个completed)
    func variableDemo() {
        
        let variable = Variable<String>("默认值")
        
//        variable.value = "0"
//        variable.value = "1"
        
        variable.asObservable().addObservable("No 1").disposed(by: disposeBag)
        
        variable.value = "2"
        variable.value = "3"
        
        variable.asObservable().addObservable("No 6").disposed(by: disposeBag)
        
        variable.value = "4"
        variable.value = "5"
    }
}



extension ObservableType {
    func addObservable(_ str: String) -> Disposable {
        return subscribe {
            print("Subcription: ", str, "Event: ", $0)
        }
    }
}





