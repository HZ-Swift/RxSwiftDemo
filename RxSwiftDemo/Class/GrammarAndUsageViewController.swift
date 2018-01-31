//
//  GrammarAndUsageViewController.swift
//  RxSwiftDemo
//
//  Created by Harious on 2018/1/31.
//  Copyright © 2018年 enetic. All rights reserved.
//

import UIKit
import RxSwift

class GrammarAndUsageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
//        observableGrammarAndUsage()
        
        subjectGrammarAndUsage()
    }
    
    /// Observable的一些用法
    func observableGrammarAndUsage() {
        
        let numberSquence = Observable.just(5)
        let numberSubSctiption = numberSquence.subscribe { (event) in
            print(event)
        }
        numberSubSctiption.dispose() // 取消订阅
        
        let helloSquence = Observable.from(["H", "E", "L", "L", "O"])
        helloSquence.subscribe { (event) in
            switch event {
            case .next(let value):
                print(event)
                print(value)
            case .error(let value):
                print(value)
            case .completed:
                print("OK")
            }
        }.dispose()
        
        _ = Observable<String>.create { (observerString) -> Disposable in
            print("观察者被创建了")
            
            observerString.on(.next("HH"))
            observerString.onCompleted()
            
            return Disposables.create()
            }.subscribe({ (event) in
                switch event {
                case .next(let value):  print(value)
                case .error(let value): print(value)
                case .completed:        print("OK")
                }
            })
    }
    
    //MARK: --------------- Subject ------------------
    /// RAC 中也有subject的存在，它可以发送信号，也可以订阅信号，本身也是信号
    func subjectGrammarAndUsage() {
        
        publishSubjectGrammarAndUsage()
        
        behaviorSubjectGrammarAndUsage()

        replaySubjectGrammarAndUsage()
    }
    
    //MARK: --------------- PublishSubject ------------------
    func publishSubjectGrammarAndUsage() {
        
        // PublishSubject 只接受被订阅后发送的消息, 不接受订阅前发送的消息
        let publishSubject = PublishSubject<String>()
        publishSubject.onNext("Hello")  // 发送一个信号
        
        let publishSubscriptionOne = publishSubject.subscribe { (value) in
            print(value)
        }
        
        let publishSubscriptionTwo = publishSubject.subscribe { (value) in
            print(value)
        }
        
        publishSubject.onNext("Hello__1")
        publishSubject.onNext("Hello__2")
        
        /// publishSubscriptionOne、publishSubscriptionTwo只会打印 Hello__1、Hello__2 不会打印 Hello
    }
    
    //MARK: --------------- BehaviorSubject ------------------
    func behaviorSubjectGrammarAndUsage() {
        
        // BehaviorSubject  既能接收订阅前发送的消息，也能接收订阅后发来的消息
        let behaviorSubject = BehaviorSubject(value: "A")
        let behaviorSubscriptionOne = behaviorSubject.subscribe { (event) in
            print("订阅者 1 号  \(event)")
        }
        behaviorSubject.onNext("B")
        behaviorSubject.onNext("C")
        behaviorSubject.onNext("D")
        
        let behaviorSubscriptionTwo = behaviorSubject.subscribe { (event) in
            print("订阅者 2 号  \(event)")
        }
        behaviorSubject.onNext("E")
        
        
        /// 订阅者One会打印 A、B、C、D、E  BehaviorSubject的第一个订阅者,能接收到所有的发送来的消息
        /// 订阅者Two会打印 D、E  BehaviorSubject的非第一个订阅者,只能接收到订阅前最后一条消息和订阅后第一条消息
    }
    
    //MARK: --------------- ReplaySubject ------------------
    // mark
    func replaySubjectGrammarAndUsage() {
        
        /// ReplaySubject可以收到订阅前后订阅后的消息
        
        let accountSubject = ReplaySubject<Double>.create(bufferSize: 3)
        
        accountSubject.onNext(22)
        
        let accountManagerOne = accountSubject.subscribe {
            print("1  \($0)")
        }
        
        accountSubject.onNext(33.3)
        accountSubject.onNext(44.44)
        accountSubject.onNext(55.555)
        accountSubject.onNext(66.6666)
        
        let accountManagerTwo = accountSubject.subscribe {
            print("2  \($0)")
        }
        
        /// 订阅者One会打印 22.0、33.3、44.44、55.555、66.6666  ReplaySubject的第一个订阅者,能接收到所有的发送来的消息
        /// 订阅者Two会打印 44.44、55.555、66.6666  ReplaySubject的非第一个订阅者,只能接收到限制数量的消息（最新的那几条消息）
    }

}
