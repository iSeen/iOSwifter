//
//  CircularView.m
//  CodeCollection
//
//  Created by ZhangNing on 2016/11/9.
//  Copyright © 2016年 iSeen. All rights reserved.
//

#import "CircularView.h"

@implementation CircularView

+ (UIView *)circularViewWithFrame:(CGRect)viewFrame lineLenthPercentage:(CGFloat)percentage lineWidth:(CGFloat)lineWidth color:(UIColor *)color {
    
    UIView *circularView = [[UIView alloc] initWithFrame:viewFrame];

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.lineWidth = lineWidth;
    [circularView.layer addSublayer:shapeLayer];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(circularView.bounds.size.height/2, circularView.bounds.size.width/2)
                                                        radius:viewFrame.size.width
                                                    startAngle: -M_PI_2
                                                      endAngle: M_PI * 2.0 * percentage - M_PI_2
                                                     clockwise:YES];
    shapeLayer.path = path.CGPath;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 2.0;
    pathAnimation.byValue = @(0.01);
    pathAnimation.fromValue = @(0);
    pathAnimation.toValue = @(1);
    pathAnimation.removedOnCompletion = YES;
    
    [shapeLayer addAnimation:pathAnimation forKey:nil];
    return circularView;
}



@end
