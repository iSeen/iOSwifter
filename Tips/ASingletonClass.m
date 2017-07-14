//
//  ASingletonClass.m
//  iOSwifter
//
//  Created by ZN on 2017/7/14.
//  Copyright © 2017年 iOSwifter. All rights reserved.
//

#import "ASingletonClass.h"
#import <objc/runtime.h>

@implementation ASingletonClass

+ (id)sharedInstance {
    static __weak ASingletonClass *instance;
    ASingletonClass *strongInstance = instance;
    @synchronized(self) {
        if (strongInstance == nil) {
            strongInstance = [[[self class] alloc] init];
            instance = strongInstance;
        }
    }
    return strongInstance;
}

- (void)setContext:(NSString *)context {
    id __weak weakObject = context;
    id (^block)() = ^{ return weakObject; };
    objc_setAssociatedObject(self, @selector(context), block, OBJC_ASSOCIATION_COPY);
}

- (NSString *)context {
    id (^block)() = objc_getAssociatedObject(self, @selector(context));
    id curContext = (block ? block() : nil);
    return curContext;
}

@end
