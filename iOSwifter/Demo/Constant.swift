//
//  ZNConstant.swift
//  LearnSwift
//
//  Created by ZhangNing on 2016/10/11.
//  Copyright © 2016年 iSeen. All rights reserved.
//

import UIKit

/// AppStore中的应用id
let APPLE_ID = ""

/// 第三方服务的 KEY
let WX_APP_ID = ""
let WX_APP_SECRET = ""

/// 屏幕宽度
let screenWidth = UIScreen.main.bounds.size.width

/// 屏幕高度
let screenHeight = UIScreen.main.bounds.size.height

/// 屏幕bounds
let screenBounds = UIScreen.main.bounds

/// 分辨率的倍数
let screenScale = UIScreen.main.scale


public typealias JSONDictionary = [String: Any]


func ZNLog(item: Any...) {
    #if DEBUG
        print("文件: "+"\(NSURL(fileURLWithPath:#file).lastPathComponent!)")
        print("内容:\n"+"\(item.last!)")
    #endif
}

struct globalVariables {
    static let urlLink = URL.init(string: "http://xxx")
}

