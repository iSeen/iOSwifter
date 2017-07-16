//
//  RACSampleModel.swift
//  iOSwift
//
//  Created by ZhangNing on 2016/10/11.
//  Copyright © 2016年 iSeen. All rights reserved.
//

import UIKit

class RACSampleModel: NSObject, NSCoding {

    /// 属性
    var sampleStr: String?
    
    override init() {
        self.sampleStr = ""
    }
    
    /// KVC 字典转模型
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    // MARK: - 归档和解档
    func encode(with aCoder: NSCoder) {
        aCoder.encodeConditionalObject(sampleStr
            , forKey: "sampleStr")
    }
    
    required init?(coder aDecoder: NSCoder) {
        aDecoder.decodeObject(forKey: "sampleStr")
    }
    
}


