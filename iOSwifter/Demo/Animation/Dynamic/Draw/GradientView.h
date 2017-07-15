//
//  GradientView.h
//  CodeCollection
//
//  Created by ZhangNing on 2016/11/9.
//  Copyright © 2016年 iSeen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradientView : UIView

/**
 渐变 (局限性: 无法自定义整个渐变区域的形状)

 @param viewFrame         View的Frame
 @param colors            渐变颜色
 @param locations         渐变颜色的分割点
 @param startPoint        颜色渐变的方向，范围在(0,0)与(1.0,1.0)之间, 如(0,0)(1.0,0)代表水平方向渐变
 @param endPoint          颜色渐变的方向，范围在(0,0)与(1.0,1.0)之间, 如(0,0)(0,1.0)代表竖直方向渐变
 @return                  渐变View
 */
+ (UIView *)gradientLayerViewWithFrame:(CGRect)viewFrame colors:(NSArray *)colors locations:(NSArray<NSNumber *> *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

@end
