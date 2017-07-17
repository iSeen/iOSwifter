//
//  ReusableView.swift
//  iRxSwift
//
//  Created by ZN on 2017/3/13.
//  Copyright © 2017年 iSeen. All rights reserved.
//

import UIKit

protocol POPReusableView: class {
    
}

extension POPReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
