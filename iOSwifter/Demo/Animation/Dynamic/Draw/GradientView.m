//
//  GradientView.m
//  CodeCollection
//
//  Created by ZhangNing on 2016/11/9.
//  Copyright © 2016年 iSeen. All rights reserved.
//

#import "GradientView.h"

@implementation GradientView

+ (UIView *)gradientLayerViewWithFrame:(CGRect)viewFrame colors:(NSArray *)colors locations:(NSArray<NSNumber *> *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    
    UIView *gradientView = [[UIView alloc] initWithFrame:viewFrame];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = colors;
    gradientLayer.locations = locations;
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;
    gradientLayer.frame = viewFrame;
    [gradientView.layer addSublayer:gradientLayer];
    return gradientView;
}

@end
