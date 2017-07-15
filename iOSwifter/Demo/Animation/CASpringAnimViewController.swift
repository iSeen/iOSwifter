//
//  CASpringAnimViewController.swift
//  iOSwift
//
//  Created by ZN on 2017/2/7.
//  Copyright © 2017年 iSeen. All rights reserved.
//

import UIKit

class CASpringAnimViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let label = UILabel(frame: CGRect(x: 10, y: 200, width: 50, height: 30))
        label.backgroundColor = UIColor.red
        view.addSubview(label)
        let spring = CASpringAnimation(keyPath: "position.x")
        spring.damping = 5;
        spring.stiffness = 100;
        spring.mass = 1;
        spring.initialVelocity = 0;
        spring.fromValue = label.layer.position.x;
        spring.toValue = label.layer.position.x + 100;
        spring.autoreverses = true
        spring.repeatCount = Float.infinity
        spring.duration = spring.settlingDuration;
        label.layer.add(spring, forKey: spring.keyPath)
    }
}
