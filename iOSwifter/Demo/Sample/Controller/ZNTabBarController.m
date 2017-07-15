//
//  ZNTabBarController.m
//  iOSwift
//
//  Created by ZhangNing on 2016/11/21.
//  Copyright © 2016年 iSeen. All rights reserved.
//

#import "ZNTabBarController.h"

#define kClassKey   @"rootVCClassString"
#define kTitleKey   @"title"
#define kImgKey     @"imageName"
#define kSelImgKey  @"selectedImageName"

@interface ZNTabBarController ()
@property (nonatomic, copy) NSArray *childItemsArray;
@end

@implementation ZNTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _childItemsArray = @[
                         @{kClassKey : @"ZNSwiftTableViewController",
                           kTitleKey : @"Swift",
                           kImgKey   : @"button_a_default",
                           kSelImgKey: @"button_a_right"},
                         
                         @{kClassKey : @"ZNObjcTableViewController",
                           kTitleKey : @"Objective-C",
                           kImgKey   : @"button_b_default",
                           kSelImgKey: @"button_b_right"}
                         ];
    [self loadItems];
}

- (void)loadItems {

    [_childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        UIViewController *vc = [NSClassFromString(dict[kClassKey]) new];
        vc.title = dict[kTitleKey];

        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self tabBarItemWithNava:nav dict:dict];
        [self addChildViewController:nav];
    }];
    
    
    
    UIImage *findSelectImg = [UIImage imageNamed:@"button_a_default"];
    UIImage *findUnSelectImImg = [UIImage imageNamed:@"button_a_right"];
    UIViewController *vc = [UIViewController new];
    UINavigationController *findNaviVC = [[UINavigationController alloc] initWithRootViewController:vc];
    findNaviVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:[UIImage imageWithCGImage:findUnSelectImImg.CGImage scale:1.5 orientation:findUnSelectImImg.imageOrientation] selectedImage:[UIImage imageWithCGImage:findSelectImg.CGImage scale:1.5 orientation:findSelectImg.imageOrientation]];
    [findNaviVC.tabBarItem setImageInsets:UIEdgeInsetsMake(-14, 0, 14, 0)];
    findNaviVC.tabBarItem.tag = 2;
    findNaviVC.tabBarItem.selectedImage = [findSelectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    findNaviVC.tabBarItem.image = [findUnSelectImImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:findNaviVC];
}

- (UITabBarItem *)tabBarItemWithNava:(UINavigationController *)nav dict:(NSDictionary *)dict {
    UITabBarItem *item = nav.tabBarItem;
    item.title = dict[kTitleKey];
    item.image = [[UIImage imageNamed:dict[kImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item.selectedImage = [[UIImage imageNamed:dict[kSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor darkGrayColor]} forState:UIControlStateSelected];
    return item;
}

@end
