//
//  UIDevice+ScreenModel.swift
//  iRxSwift
//
//  Created by ZN on 2017/2/25.
//  Copyright © 2017年 iSeen. All rights reserved.
//  https://github.com/nixzhu/dev-blog/blob/master/2015-05-18-screen-model.md

import UIKit

extension UIDevice {
    
    enum ScreenModel {
        case Classic
        case Bigger
        case BiggerPlus
    }
    
    static let screenModel: ScreenModel = {
        
        let screen = UIScreen.main
        let nativeWidth = screen.nativeBounds.size.width
        
        if nativeWidth == 320 * 2 {
            return .Classic
            
        } else if nativeWidth == 375 * 2 {
            return .Bigger
            
        } else if nativeWidth == 414 * 3 {
            return .BiggerPlus
        }
        
        return .Bigger // Default
    }()
    
    class func matchMarginFrom(classic: CGFloat, _ bigger: CGFloat, _ biggerPlus: CGFloat) -> CGFloat {
        switch screenModel {
        case .Classic:
            return classic
        case .Bigger:
            return bigger
        case .BiggerPlus:
            return biggerPlus
        }
    }
}
