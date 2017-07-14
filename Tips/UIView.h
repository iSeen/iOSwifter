//
//  UIView.h
//  iOSwifter
//
//  Created by ZN on 2017/7/14.
//  Copyright © 2017年 iOSwifter. All rights reserved.
//

#ifndef UIView_h
#define UIView_h

// 禁止WKWebView的左右弹性属性(一直居中显示)
self.webView.scrollView.delegate = self;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    scrollView.contentOffset = CGPointMake((scrollView.contentSize.width - screenWidth) / 2, scrollView.contentOffset.y);
}



#endif /* UIView_h */
