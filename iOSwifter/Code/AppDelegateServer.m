//
//  AppDelegateServer.m
//  iOSwifter
//
//  Created by ZN on 2017/7/15.
//  Copyright © 2017年 iOSwifter. All rights reserved.
//

#import "AppDelegateServer.h"
#import "AppDelegate.h"
extern CFAbsoluteTime StartTime;

@implementation AppDelegateServer

+ (void)load {
    __block id observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
         [self setUp];
        [[NSNotificationCenter defaultCenter] removeObserver:observer];
    }];
}

+ (void)setUp {
    //iOS自带悬浮窗调试工具
#if DEBUG
    id overlayClass = NSClassFromString(@"UIDebuggingInformationOverlay");
    [overlayClass performSelector:NSSelectorFromString(@"prepareDebuggingOverlay")];
#endif
    
    //通过打点方式计算 main加载到didFinishLunch加载的时间
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"Launched in %f sec", CFAbsoluteTimeGetCurrent() - StartTime);
    });
}

// http://blog.sunnyxx.com/2015/03/09/notification-once/

@end
