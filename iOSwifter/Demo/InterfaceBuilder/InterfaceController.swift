//
//  InterfaceController.swift
//  iOSwift
//
//  Created by ZN on 16/11/30.
//  Copyright © 2016年 iSeen. All rights reserved.
//

import UIKit

class InterfaceController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    @IBAction func pushIBvc(_ sender: UIButton) {
        
        //确保你的StoryBoard的名称和实体类的名称完全相同，否则,当视图引用这个StoryBoard时, 应用程序会崩溃.
//        let interDetailVC = InterfaceDetailController.storyBoardInstance()
//        self.present(interDetailVC!, animated: true, completion: nil);
        
//        //需要知道这个StoryBoard的名字, 还需要提供这个ViewController在StoryBoard中的ID, 而且你在创建HomeViewController时, 每次都要使用这种方式;
        let storyBoard = UIStoryboard.init(name: "InterfaceDetailController", bundle: nil)
        let interDetailVC = storyBoard.instantiateViewController(withIdentifier: "InterfaceDetailController")
        self.navigationController?.pushViewController(interDetailVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
