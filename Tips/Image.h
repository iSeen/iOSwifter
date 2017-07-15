//
//  Image.h
//  iOSwifter
//
//  Created by ZN on 2017/7/15.
//  Copyright © 2017年 iOSwifter. All rights reserved.
//

#ifndef Image_h
#define Image_h

/// 技巧1: 改变图片的颜色
let imageName = "button_right_selected"

let button = UIButton(frame: CGRect(x: 10, y: 200, width: 200, height: 200))
button.centerX = view.width/2
button.setTitle("需查看.swift文件", for: .normal)
button.setBackgroundImage(UIImage.init(named: imageName), for: .normal)
//方式一: Asset Catalog选中左边图片名，右边 Attributes Inspector / Render As选项改成Template Image, 然后代码设置tintColor颜色
//方式二: 在Storyboard中，在Attributes Pane中改变UIImageView的tintColor属性
button.tintColor = UIColor.green
view.addSubview(button)

/// 技巧二 使用矢量PDF
/*
 Xcode 6 及以上版本支持在Asset Catalog中使用矢量PDF.
 
 在iOS平台，Xcode是在编译时，根据你的矢量PDF图的大小，生成1x、2x和3x图。如果你的PDF图是45*45px，那么Xcode会在编译时生成下面3个PNG：
 45*45px ：1x设备用的(iPhone 3G and 3GS)
 90*90px ：2x或Retina显示设备用的(iPhone 4, 4S, 5, 5S, and 6)
 135*135px ：3x设备用的(iPhone 6 Plus 及以上)
 
 这也意味着当有更高的屏幕分辨率时，Xcode可以根据已有的矢量PDF放大图片，这样自动就支持以后的设备了。还有，如果你是OS X开发者，那么矢量PDF就更好用了，OS X app完全支持矢量PDF，你可以用代码缩放图片而不会失真。
 
 而你需要做的就是，找你的好基友设计师拿到这些矢量PDF文件，然后在Asset Catalog的Attribtues Pane中，在Scale Factor的下拉框中选择Single Vector就行了。
 */


/// 技巧三 启动图用xib
/*
 启动图可设置在Asset Catalog中，建议使用LaunchScreen xibs;
 1.选择Launch Screen类型的xib, 创建一个xib文件;
 2.选择app的target，在Launch Screen file处选择你的Launch Screen.xib文件
 */


/// 技巧四 图片拉伸

/*
 之前，一般用类似下面的代码来获得可改变大小的图片;
 
 let edgeInsets = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
 let backgroundButtonImage = UIImage(named:"purple_button")?.resizableImage(withCapInsets: edgeInsets)
 let button = UIButton()
 button.setBackgroundImage(backgroundButtonImage, for: .normal)
 
 在运行时，会拉伸距离UIImageView的container的边框8像素的中间部分，这样就能保留圆角.
 
 多亏Xcode中Asset Catalog的slice和dice，我们不需要代码也能拉伸图片。
 1.首先在Xcode中选中图片，然后点击右下角的Show Slicing, 现在应该能看到slicing 面板和一个按钮"Start Slicing"
 2.点击按钮之后，会显示下面的三个选项：
 左边按钮用于horizontal edge insets，右边的按钮用于vertical edge insets，中间的则是两个都有。
 因我们要保留圆角，所以我们按中间的按钮，告诉系统我们想要按钮的中间在水平和垂直方向拉伸。在按下按钮之后，就能看到一些可以拖动的细条，这可以拖动设置从哪里开始拉伸图片。
 (系统会保留深色区域，浅色区域会被拉伸。更厉害的是，Xcode自动找到了圆角，所以我们不需要设置从哪里开始拉伸图片。最后别忘了在Attribtues pane中设置图片是可拉伸的: Slicing / Center 设置为 Stretches)
 */
// 以上摘自: http://benbeng.leanote.com/post/4%E4%B8%AA%E4%BD%A0%E9%9C%80%E8%A6%81%E7%9F%A5%E9%81%93%E7%9A%84Asset-Catalog%E7%9A%84%E7%A7%98%E5%AF%86?utm_source=tuicool&utm_medium=referral


#endif /* Image_h */
