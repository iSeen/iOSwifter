//
//  Singleton.swift
//  iRxSwift
//
//  Created by ZN on 2017/2/24.
//  Copyright © 2017年 iSeen. All rights reserved.
//  单例
/*
 实例唯一性, 初始化方法必须私有, 线程安全
 以下做法可以保证编译器在某个类尝试使用()来初始化TheOneAndOnlyKraken时，抛出错误.
 */

import Foundation

class Singleton {
    static let sharedInstance = Singleton()
    private init() {}
}
