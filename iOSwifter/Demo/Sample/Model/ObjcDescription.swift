//
//  ObjcDescription.swift
//  iOSwift
//
//  Created by ZN on 16/12/12.
//  Copyright © 2016年 iSeen. All rights reserved.
//

import UIKit

class ObjcDescription: BaseModel {
    var name: String?
    var age: Int = 0
    var work: String?
    
    // 若类继承NSObject, 直接重写Description, 无需相关协议
//    override var description: String {
//        return "ObjcDescription: name: \(name), age: \(age)"
//    }
}
