//
//  DashLine.m
//  ZNDashLine
//
//  Created by ZhangNing on 2016/11/7.
//  Copyright © 2016年 iSeen. All rights reserved.
//

#import "DashLine.h"

@implementation DashLine

+ (UIView *)dashLineWithdrawFrame:(CGRect)drawFrame direction:(LineDirection)direction singleLineLength:(int)singleLineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor {
    
    UIView *lineView = [[UIView alloc] initWithFrame:drawFrame];
    
    CGFloat drawViewWidth = CGRectGetWidth(drawFrame);
    CGFloat drawViewHeight = CGRectGetHeight(drawFrame);
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    [shapeLayer setStrokeColor:lineColor.CGColor]; //设置颜色
    
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:
                                    [NSNumber numberWithInt:singleLineLength],   //设置线宽
                                    [NSNumber numberWithInt:lineSpacing], nil]]; //线间距
    
    CGPoint position;
    CGFloat lineWidth;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    
    if (direction == LineDirectionLevel) {
        position = CGPointMake(drawViewWidth/2, drawViewHeight);
        lineWidth = drawViewHeight;
        CGPathAddLineToPoint(path, NULL, drawViewWidth, 0);
        
    } else {
        position = CGPointMake(drawViewWidth, drawViewHeight/2);
        lineWidth = drawViewWidth;
        CGPathAddLineToPoint(path, NULL, 0, drawViewHeight);
    }
    
    [shapeLayer setPosition:position];
    [shapeLayer setLineWidth: lineWidth]; //设置虚线宽度
    
    [shapeLayer setPath:path]; //设置路径
    CGPathRelease(path);
    [lineView.layer addSublayer:shapeLayer]; //添加绘制的虚线
    lineView.clipsToBounds = YES;
    return lineView;
}

@end
