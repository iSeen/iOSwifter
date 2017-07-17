//
//  Shakeable.swift
//  iRxSwift
//
//  Created by ZN on 2017/3/13.
//  Copyright © 2017年 iSeen. All rights reserved.
//

import UIKit

protocol POPShakeable {
    
}

extension POPShakeable where Self: UIView {
    func shake() {
        let animation = CABasicAnimation(keyPath: "position");
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4.0, y: self.center.y - 2.0))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4.0, y: self.center.y + 2.0))
        layer.add(animation, forKey: "position")
    }
}
