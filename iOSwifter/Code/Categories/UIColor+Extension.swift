//
//  UIColor+Extension.swift
//  iOSwift
//
//  Created by ZhangNing on 2016/10/11.
//  Copyright © 2016年 iSeen. All rights reserved.
//

import UIKit

extension UIColor {
    
    // 快速构建rgb颜色
    class func colorWithRGB(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
    }
    
    // 随机颜色
    class func randomColor() -> UIColor {
        let r = CGFloat(arc4random_uniform(256))
        let g = CGFloat(arc4random_uniform(256))
        let b = CGFloat(arc4random_uniform(256))
        return UIColor.colorWithRGB(r: r, g: g, b: b)
    }
}
