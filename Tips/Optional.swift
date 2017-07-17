//
//  Optional.swift
//  iRxSwift
//
//  Created by ZN on 2017/2/24.
//  Copyright © 2017年 iSeen. All rights reserved.
//

import Foundation

class Optional {
    
    // 一种枚举定义
    func optionalFunc() {
        
        let str: String? = nil
        
        //1 推荐, Optional Chaining(可进行链式操作), 使用 if let 语法可以更加安全的操作 Optional 值。只有在 str 中的值不为 nil 的时候，tempStr 变量才会被初始化成功。 这样 print 语句就不会因为 nil 而崩溃。
        if let tempStr = str {
            print(tempStr)
        }
        
        //2
        if str != nil {
            print(str!)
        }
        
        /*
         person?.name?.firstName  
         这个引用中，person 和 name 都是 Optional 的。只要一个表达式中有一个 Optional 的值，整个表达式的结果就都是 Optional 的，不论最后一个属性本身是否是 Optional 的。
         
         if let firstName = person?.name?.firstName {
             print(firstName)
         }
         
         func getName(person: Person) -> String? {
             return person.name?.firstName
         }
         */
        
        
         /*
         Swift 之 KVC:

         需显示声明继承 NSObject(NSObject实现了NSKeyValueCoding协议),
         Swift中通过 valueForKey 方法返回的是一个 Optional 值, 需要对返回值做一次解包处理，才能得到实际的属性值。
         好处: 不用过多的依赖编译时的限制，而是为我们提供了更多的运行时的能力。
         
         //属性的属性
         .valueForKeyPath("address.firstLine")!
         print(view.valueForKeyPath("superview.superview"))

         
         */
        
    }
}

class Person: NSObject {
    
    let firstName: String
    let lastName: String
    
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    //KVC .valueForKey("noExist") 
    //类中是没有 noExist 这个属性的，所以 KVC 也无法找到这个属性值，这时候 KVC 协议其实会调用 valueForUndefinedKey 方法，NSObject 对这个方法的默认实现是抛出一个 NSUndefinedKeyException 异常。所以如果我们没有自己重写 valueForUndefinedKey 方法的话，这时应用就会因为异常崩溃。
    override func value(forUndefinedKey key: String) -> Any? {
        return ""
    }
    
    /*
     setValue:forKey:
     和 valueForKey 一样，如果我们给 setValue 传递一个不存在的 key 值，KVC 就会去调用 setValue: forUndefinedKey 方法，NSObject 对这个方法的默认实现依然是抛出一个 NSUndefinedKeyException 异常。
     */
}
