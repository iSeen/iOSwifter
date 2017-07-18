//
//  main.m
//  iOSwifter
//
//  Created by ZN on 2017/7/15.
//  Copyright © 2017年 iOSwifter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
CFAbsoluteTime StartTime;

int main(int argc, char * argv[]) {
    @autoreleasepool {
        StartTime = CFAbsoluteTimeGetCurrent();
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

/*
 argc 系统传入参数的个数
 agrv 系统传入参数的值列表
 principalClassName表示要创建的应用程序对象(app的象征，该类必须是UIApplication或者它的字类)。如果传nil默认就表示UIApplication类。
 delegateClassName表示 给应用程序指定一个代理对象,该类必须遵守UIApplicationDelegate协议
 http://www.jianshu.com/p/57f6acfdc4c2
 */


