//
//  CAKeyframeAnimationController.swift
//  iOSwift
//
//  Created by ZN on 2017/2/7.
//  Copyright © 2017年 iSeen. All rights reserved.
//

import UIKit

class CAKeyframeAnimationController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let tempView = UIView(frame: CGRect(x: 50, y: 100, width: 250, height: 500))
        let bezierPath = UIBezierPath(ovalIn: tempView.frame)
        
        let animView = UIView(frame: CGRect(x: 50, y: 50, width: 70, height: 80))
        animView.backgroundColor = UIColor.red
        view.addSubview(animView)
        
        let orbitAnim = CAKeyframeAnimation(keyPath: "position")
        orbitAnim.duration = 5
        orbitAnim.path = bezierPath.cgPath
        orbitAnim.calculationMode = kCAAnimationPaced
        orbitAnim.fillMode = kCAFillModeForwards
        orbitAnim.repeatCount = Float.infinity
        orbitAnim.rotationMode = kCAAnimationRotateAutoReverse
        animView.layer.add(orbitAnim, forKey: "orbitAnim")
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.purple.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 0.5
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.path = bezierPath.cgPath
        view.layer.addSublayer(shapeLayer)
    }
}
