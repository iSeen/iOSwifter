//
//  SwiftDescription.swift
//  iOSwift
//
//  Created by ZN on 16/12/12.
//  Copyright © 2016年 iSeen. All rights reserved.
//

import UIKit

class SwiftDescription {
    var name: String?
    var age: Int?
}

/* 对象自我描述
 默认打印OC对象, 会打印内存地址
 默认打印Swift对象, 会打印类名
 
 重写Custom[Debug]StringConvertible协议属性 [debug]Description
 若类继承NSObject, 直接重写Description, 无需相关协议
 */
extension SwiftDescription: CustomStringConvertible {
    var description: String {
        return "SwiftDescription-description: name:\(name), age: \(age)"
    }
}

extension SwiftDescription: CustomDebugStringConvertible {
    var debugDescription: String {
        //return self.description
        return "SwiftDescription-debugDescription: name:\(name), age: \(age)"
    }
}
