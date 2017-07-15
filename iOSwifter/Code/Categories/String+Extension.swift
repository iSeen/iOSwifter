//
//  NSString+Extension.swift
//  iOSwift
//
//  Created by ZhangNing on 2016/12/11.
//  Copyright © 2016年 iSeen. All rights reserved.
//

import UIKit

extension String {
    
    public func isHttpType(urlString: String) -> Bool {
        guard (urlString.range(of: "http") != nil) else {
            return false
        }
        return true
    }
    
}
