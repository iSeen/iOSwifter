//
//  ZNIBDesignableView.m
//  iOSwift
//
//  Created byß ZhangNing on 2016/11/24.
//  Copyright © 2016年 iSeen. All rights reserved.
//

#import "ZNIBDesignableView.h"

@implementation ZNIBDesignableView

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
}

@end
