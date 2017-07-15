//
//  ZNSphereController.swift
//  iOSwift
//
//  Created by ZN on 16/10/14.
//  Copyright © 2016年 iSeen. All rights reserved.
//

import UIKit

class ZNSphereController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(sphereView)
    }
    
    func buttonAction(button: UIButton) {
        print("点击了\(button.title(for: .normal))")
        
        sphereView.timerStop()
        
        UIView.animate(withDuration: 0.3, animations: {
            button.transform = CGAffineTransform.init(scaleX: 2.0, y: 2.0)
        }) { (_) in
            UIView.animate(withDuration: 0.3, animations: {
                button.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
                }, completion: { (_) in
                    self.sphereView.timerStart()
            })
        }
    }
    
    
    lazy var sphereView: DBSphereView = {
        
        let sphereView = DBSphereView(frame: CGRect(x: 0, y: 100, width: screenWidth, height: screenWidth))
        sphereView.backgroundColor = UIColor.white
        
        var array = [UIButton]()
        
        for i in 0..<50 {
            let button = UIButton(type: UIButtonType.system)
            button.frame = CGRect(x: 0, y: 0, width: 60, height: 20)
            button.setTitle("P\(i)", for: .normal)
            button.setTitleColor(UIColor.darkGray, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            array.append(button)
            sphereView.addSubview(button)
        }
        sphereView.setCloudTags(array)
        return sphereView
    }()
}
