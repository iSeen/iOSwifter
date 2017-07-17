//
//  POPViewController.swift
//  iRxSwift
//
//  Created by ZN on 2017/3/13.
//  Copyright © 2017年 iSeen. All rights reserved.

//  面向协议编程

import UIKit

class POPViewController: UIViewController {
    
    
    @IBOutlet weak var button: ActionButton!
    
    @IBAction func btnAction(_ sender: ActionButton) {
        sender.shake()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

class ActionButton: UIButton, POPShakeable {
    
}

