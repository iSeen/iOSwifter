//
//  ZNTableViewCell.swift
//  iRxSwift
//
//  Created by ZN on 2017/2/16.
//  Copyright © 2017年 iSeen. All rights reserved.
//

import UIKit

class RxTableViewCell: UITableViewCell {
    
    var user: RxUser? {
        willSet {
            backgroundColor = UIColor.red
            textLabel?.text = "\(newValue?.screenName)关注了\(newValue?.followingCount), 并且被\(newValue?.followersCount)关注"
            textLabel?.numberOfLines = 0
        }
    }
}
