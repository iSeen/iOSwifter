//
//  UIButton+ImageTitleSpacing.h
//  WxySquareButton
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WxyButtonEdgeInsetsStyle) {
    WxyButtonEdgeInsetsStyleImageTop,     // 图片在上，文字在下
    WxyButtonEdgeInsetsStyleImageLeft,    // 图片在左，文字在右
    WxyButtonEdgeInsetsStyleImageBottom,  // 图片在下，文字在上
    WxyButtonEdgeInsetsStyleImageRight,   // 图片在右，文字在左
};

@interface UIButton (ImageTitleSpacing)

/**

 @param style 选择button上图片文字位置关系
 @param space 图片文字间距
 */
- (void)layoutButtonWithEdgInsetsStyle:(WxyButtonEdgeInsetsStyle)style
                    imageTitleSpacing:(CGFloat)space;

@end
