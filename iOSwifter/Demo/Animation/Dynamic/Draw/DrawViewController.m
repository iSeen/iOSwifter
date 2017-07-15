//
//  DrawViewController.m
//  CodeCollection
//
//  Created by ZhangNing on 2016/11/9.
//  Copyright © 2016年 iSeen. All rights reserved.
//

#import "DrawViewController.h"
#import "DashLine.h"
#import "GradientView.h"
#import "CircularView.h"

@interface DrawViewController ()

@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //圆弧
    UIView *circularView = [CircularView circularViewWithFrame:CGRectMake(150, 260, 100, 100)
                                           lineLenthPercentage:80/100.0
                                                     lineWidth:5
                                                         color:[UIColor cyanColor]];
    [self.view addSubview:circularView];
    
    
    //渐变
    UIView *gradientView = [GradientView gradientLayerViewWithFrame:CGRectMake(50, 70, 200, 50)
                                                             colors:@[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor yellowColor].CGColor, (__bridge id)[UIColor blueColor].CGColor]
                                                          locations:@[@0.3, @0.5, @1.0]
                                                         startPoint:CGPointMake(0, 0)
                                                           endPoint:CGPointMake(1.0, 0)];
    [self.view addSubview:gradientView];
    
    
    //虚线 横线
    UIView *levelDashLineView = [DashLine dashLineWithdrawFrame:CGRectMake(50, 64, 300, 1) direction:LineDirectionLevel singleLineLength:30 lineSpacing:5 lineColor:[UIColor redColor]];
    [self.view addSubview:levelDashLineView];
    
    //虚线 横线
    UIView *dashLineView = [DashLine dashLineWithdrawFrame:CGRectMake(50, 64, 5, 300) direction:LineDirectionVertical singleLineLength:50 lineSpacing:5 lineColor:[UIColor redColor]];
    [self.view addSubview:dashLineView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
