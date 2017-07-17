//
//  ConceptController.swift
//  iRxSwift
//
//  Created by ZN on 2017/2/17.
//  Copyright © 2017年 iSeen. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ConceptController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        //Observable
        rxExtension()
        
    }

    /*
     1. rx extension (需要导入RxCocoa)
     点击事件添加Target-Action问题在于需要重新取名字，且丢失了上下文.
     RxSwift (确切说是 RxCocoa) 给系统的诸多原生控件提供了 rx 扩展.
     */
    func rxExtension() {
        
        //一行代码 搞定输入框输入, label实时显示
        _ = textField.rx.text.bindTo(lab.rx.text)
        
        //Tap事件处理
        let disposeBag = DisposeBag()
        let tap = UITapGestureRecognizer()
        tap.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.view.endEditing(true)
            })
            .addDisposableTo(disposeBag)
        view.addGestureRecognizer(tap)
    }
    
    lazy var textField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        textField.backgroundColor = UIColor.yellow
        self.view.addSubview(textField)
        return textField
    }()
    lazy var lab: UILabel = {
        let lab = UILabel(frame: CGRect(x: 100, y: 200, width: 100, height: 50))
        lab.backgroundColor = UIColor.orange
        self.view.addSubview(lab)
        return lab
    }()
    
    
    /*
     2.Observable.create
     可以将 Native 的 object 包装成 Observable，比如对网络请求的封装
     */
    
//    public func response(_ request: URLRequest) -> Observable<(Data, HTTPURLResponse)> {
//        return Observable.create { observer in
//            let task = self.dataTaskWithRequest(request) { (data, response, error) in
//                observer.on(.next(data, httpResponse))
//                observer.on(.completed)
//            }
//            task.resume()
//            
//            return Disposables.create {
//                task.cancel()
//            }
//        }
//    }
    
    //使用
//    let disposeBag = DisposeBag()
//    response(aRequest)
//    .subscribe(onNext: { data in
//    print(data)
//    })
//    .addDisposableTo(disposeBag)
    
    
    /*
     3. Variable()
     Variable(value) 可以把 value 变成一个 Observable，不过前提是使用新的赋值方式 aVariable.value = newValue;
     原理:
     通过 subject 来做的，大意是把 value 存到一个内部变量 _value 里，当调用 value 方法时，先更新 _value 值，然后调用内部的 _subject.on(.next(newValue)) 方法告知 subscriber。
     */
    func variableObserver() {
        let magicNumber = 42
        let magicNumberVariable = Variable(magicNumber)
        magicNumberVariable.asObservable().subscribe(onNext: {
            print("magic number is \($0)")
        })
        .addDisposableTo(DisposeBag())
    
        magicNumberVariable.value = 73
    }


    /*
     4. Subject
     简单来说是一个可以主动发射数据的 Observable，多了 onNext(value), onError(error), ‘onCompleted’ 方法，可谓全能型选手
     */
    func subjectObserver() {
//        let disposeBag = DisposeBag()
//        let subject = PublishSubject<String>()
//        
//        subject.addObserver("1").addDisposableTo(disposeBag)
//        subject.onNext("🐶")
//        subject.onNext("🐱")
//        
//        subject.addObserver("2").addDisposableTo(disposeBag)
//        subject.onNext("🅰️")
//        subject.onNext("🅱️")
    }

    
// MARK: - scheduler 切换线程
    func scheduler() {
        let observable = Observable<Int>.create { (observer: AnyObserver<Int>) -> Disposable in
            print("observable thread: \(Thread.current)")
            observer.onNext(1)
            observer.onCompleted()
            return Disposables.create()
        }
        
        let disposeBag = DisposeBag()
        
        observable
            .map { (e) -> Int in
                print("map1 thread: \(Thread.current)")
                return e + 1
            }
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .userInteractive))
//            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInteractive))
            .map { (e) -> Int in
                print("map2 thread: \(Thread.current)")
                return e + 1
            }
            .subscribe(onNext:{ (e) -> Void in
                print("subscribe thread: \(Thread.current)")
            })
            .addDisposableTo(disposeBag)
    }
    
    deinit {
        print("Con释放")
    }
}
