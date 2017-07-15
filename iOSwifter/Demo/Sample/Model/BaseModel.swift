//
//  BaseModel.swift
//  iOSwift
//
//  Created by ZN on 16/12/12.
//  Copyright © 2016年 iSeen. All rights reserved.
//

import UIKit

class BaseModel: NSObject {
    //不定义任何属性，所有用的属性都在子类，直接重写description
    internal override var description: String {
        get {
            var dict = [String:AnyObject]()
            var count: UInt32 = 0
            //获取类的公有属性列表
            var properties = class_copyPropertyList(type(of: self), &count)
            
            for _ in 0..<count {
                
                //获取属性名称, C字符串
                let t = property_getName(properties?.pointee)
                //转换成OC String?
                let n = NSString(cString: t!, encoding: String.Encoding.utf8.rawValue)
                
                let v = self.value(forKey: n as! String) ?? "nil"
                dict[n as! String] = v as AnyObject?
                properties = properties?.successor()
            }
            return "\(type(of: self)):\n\(dict)"
        }
    }
}

