//
//  InterfaceDetailController.swift
//  iOSwift
//
//  Created by ZN on 16/11/30.
//  Copyright © 2016年 iSeen. All rights reserved.
//

import UIKit

class InterfaceDetailController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    //如果你想通过 instantiateInitialViewController()来访问ViewController, 请确保你在Interface Builder中设置这个ViewController为initialViewController .
    //如果你在相同的StoryBoard中有多个ViewController, 那么你需要使用instantiateViewController(withIdentifier: _ )
    static func storyBoardInstance() -> InterfaceDetailController? {
        let storyBoard = UIStoryboard.init(name: NSStringFromClass(self), bundle: nil)
        return storyBoard.instantiateInitialViewController() as? InterfaceDetailController
    }
    
    
    //使用类似的方法从nib中初始化view:
//    class LoginView: UIView {
//        
//        static func nibInstance() -> LoginView? {
//            if let loginView =
//                Bundle.mainBundle.loadNibNamed(String.className(self),
//                                               owner: nil, options: nil)?.first as?
//                LoginView {
//                return loginView
//            }
//            return nil
//        }
//    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
