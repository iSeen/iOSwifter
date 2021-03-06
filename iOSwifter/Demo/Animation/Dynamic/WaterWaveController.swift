//
//  WaterWaveController.swift
//  iOSwift
//
//  Created by ZN on 2017/2/7.
//  Copyright © 2017年 iSeen. All rights reserved.
//
//  水波纹动画

import UIKit

/**
 正弦型函数解析式：y=Asin（ωx+φ）+h
 各常数值对函数图像的影响：
 φ（初相位）：决定波形与X轴位置关系或横向移动距离（左加右减）
 ω：决定周期（最小正周期T=2π/|ω|）
 A：决定峰值（即纵向拉伸压缩的倍数）
 h：表示波形在Y轴的位置关系或纵向移动距离（上加下减）
 */
class WaterWaveController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let singleWaterWaveView = WaterWaveView(frame:view.bounds)
        view.addSubview(singleWaterWaveView)
    }
}
