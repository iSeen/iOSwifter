//
//  UIView+Extension.swift
//  iOSwift
//
//  Created by ZhangNing on 2016/10/11.
//  Copyright © 2016年 iSeen. All rights reserved.
//

import UIKit

/// UIView 扩展 (x, y, width, height, origin, size, centerX, centerY)

extension UIView {
    
    /// x
    var x: CGFloat {
        set {
            self.frame.origin.x = newValue
        }
        get {
            return self.frame.origin.x
        }
    }
    
    /// y
    var y: CGFloat {
        set {
            self.frame.origin.y = newValue
        }
        get {
            return self.frame.origin.y
        }
    }
    
    /// width
    var width: CGFloat {
        set {
            self.frame.size.width = newValue
        }
        get {
            return self.frame.size.width
        }
    }
    
    /// height
    var height: CGFloat {
        set {
            self.frame.size.height = newValue
        }
        get {
            return self.frame.size.height
        }
    }
    
    /// origin
    var origin: CGPoint {
        set {
            self.frame.origin = newValue
        }
        get {
            return self.frame.origin
        }
    }
    
    /// size
    var size: CGSize {
        set {
            self.frame.size = newValue
        }
        get {
           return self.frame.size
        }
    }
    
    /// Center X
    var centerX: CGFloat {
        set {
            self.center.x = newValue
        }
        get {
            return self.center.x
        }
    }
    
    /// Center Y
    var centerY: CGFloat {
        set {
            self.center.y = newValue
        }
        get {
            return self.center.y
        }
    }
}
