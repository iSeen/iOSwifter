//
//  DashLine.h
//  ZNDashLine
//
//  Created by ZhangNing on 2016/11/7.
//  Copyright © 2016年 iSeen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LineDirection){
    LineDirectionLevel,    //水平横线
    LineDirectionVertical  //垂直竖线
};

@interface DashLine : UIView

/**
 绘制虚线View

 @param drawFrame          所需绘制虚线的Frame
 @param direction          水平横线或垂直竖线
 @param singleLineLength   每一小段虚线长度
 @param lineSpacing        虚线之间的间距
 @param lineColor          虚线颜色
 
 @return                   返回虚线View
 */
+ (UIView *)dashLineWithdrawFrame:(CGRect)drawFrame direction:(LineDirection)direction singleLineLength:(int)singleLineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

@end
