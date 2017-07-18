//
//  Xcode.h
//  iOSwifter
//
//  Created by ZN on 2017/7/14.
//  Copyright © 2017年 iOSwifter. All rights reserved.
//

#ifndef Xcode_h
#define Xcode_h

# 不运行程序截取手机屏幕图片到桌面
Xcode / debug菜单 / View Debugging / Take ScreenShot of ...
可设置快捷键: Xcode偏好设置, Key Bandings, 搜索View Debugging, Take ScreenShot of ...  设置为 Option + S


# 代码块 $ ./setup_snippets.sh 更改目录, 重启即可生效.
~/Library/Developer/Xcode/UserData/CodeSnippets

# Provisioning Profiles: 描述文件
~/Library/MobileDevice/Provisioning Profiles

# DerivedData: 运行安装 APP 产生的缓存文件  清除 $ ./clear_derived_data.sh
~/Library/Developer/Xcode/DerivedData

# Archives: APP 打包的ipa历史版本 / 获取dsym文件 (按照日期排列, 可保留最新的几个)
~/Library/Developer/Xcode/Archives

# Products: APP 打包的app icon历史版本 (先按Bundle Idenifier排列，后按archive版本号排列)
~/Library/Developer/Xcode/Products/

# XCPGDevices: Playground 项目缓存
~/Library/Developer/XCPGDevices/

# DocSets: 可移除旧的文档(iOS/OSX/Xcode)
~/Library/Developer/Shared/Documentation/DocSets

# Plug-ins: 插件
~/Library/Application Support/Developer/Shared/Xcode/Plug-ins

# Devices: 模拟器的缓存数据
~/Library/Developer/CoreSimulator/Devices/

# iOS DeviceSupport: 可移除对旧设备的支持
~/Library/Developer/Xcode/iOS DeviceSupport

# Runtimes: 可移除旧版本的模拟器支持
~/Library/Developer/CoreSimulator/Profiles/Runtimes/

# SDKs: 模拟器中SDK版本(谨慎删除)
~/application/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/

#endif /* Xcode_h */
