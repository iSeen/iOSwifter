//
//  RACSampleViewController.h
//  iReactiveCocoa
//
//  Created by ZhangNing on 2016/12/18.
//  Copyright © 2016年 iSeen. All rights reserved.
//
/* Ps:
 ReactiveCocoa 5.0
 如果你只是纯 swift 项目，你继续使用 ReactiveCocoa 。但是 RAC 依赖于 ReactiveSwift ，等于你引入了两个库。
 如果你的项目是纯 OC 项目，你需要使用的是 ReactiveObjC 。这个库里面包含原来 RAC 2 的全部代码。
 如果你的项目是 swift 和 OC 混编，你需要同时引用 ReactiveCocoa 和 ReactiveObjCBridge 。但是 ReactiveObjCBridge 依赖于 ReactiveObjC ，所以你就等于引入了 4 个库。
 */


#import <UIKit/UIKit.h>

@interface RACSampleViewController : UIViewController

@end
