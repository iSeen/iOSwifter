<p align="center">
	<a target='_blank' href='https://github.com/iSeen'>
<img src='https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1505628774231&di=1d72abe61cfc122283a1f2e21a495f95&imgtype=0&src=http%3A%2F%2Fwww.dedns.cn%2Fimages%2Fthumb%2F20170207%2F0ffdaced2e.jpg' width='200' height='100'/>
</a>
  <br>
</p>


# iOS11 & Xcode9 开发适配
## 目录
[iPhone X](#iPhone X)  
[iOS11](#iOS11)  
[Xcode9](#Xcode9)  
[Bug](#Bug)  

## <a id="iPhone X">iPhone X</a>
分辨率 2436*1125   
statusBar 高度: 44pt (之前20pt), 64 -> (88)  
tabbar 高度: 83pt (之前49pt), 横屏时底部高度为 33pt


## <a id="iOS11">iOS11</a>
iOS11不再支持armv7或armv7s（32位）

---
## <a id="Xcode9">Xcode9</a>
[官方介绍](https://developer.apple.com/library/content/documentation/DeveloperTools/Conceptual/WhatsNewXcode/xcode_9/xcode_9.html#//apple_ref/doc/uid/TP40004626)

#### @无线调试
真机升级iOS11, 注意一定要在一个局域网.
![](https://github.com/iSeen/Resource/raw/master/Images/wirelessdevelopment.png)
完成之后左侧Connected区域你的设备右侧会显示小地图的图标，表示你已经连接上了.

如果iphone和mac不在同一局域网，你可以按照下图进行设置:
![](https://static.oschina.net/uploads/space/2017/0610/112915_7tCQ_2279344.png)

#### @模拟器
支持多个模拟器同时开启，方便自动化测试;
模拟器边框切换, simulator / Window / Show Device Bezels

#### @Git支持
Git的管理界面直接以navigator的方式集成到Xcode中，可以方便的对自己的Git Repos进行管理。

	可以将github账户设置到Xcode中，克隆窗口将显示所有的github仓库，以及你star的仓库。你也可以搜索所有的github项目，只需要单机就可以查看项目。
	XCode -> Preferences -> Accouts / 左下角点"+", 选择 GitHub 可登录GitHub账户.
	
	全新的源代码管理器，你可以快速查看每个分支、标签、和远程分支了。并且可以查看所有修改的文件以及冲突等待。也可以这样说，你可以完全丢弃第三方代码管理器了。

#### @编辑器重构
##### 重构/转换
	新的编辑器内置了重构（refactoring）和转换（transformation）引擎，当你选择一个符号或者代码块是，编辑器将提供功能强大的操作，比如“Extract（提取）”、“Rename（重命名）”。
	支持以下转换和重构：
	    添加遗漏的协议要求
	    生成缺少的实现存根
	    为抽象方法添加缺少的重写
	    提取到局部变量
	    提取方法/表达式
	    在 switch 语句中展开默认值以生成所有适用的case
	    转换 if/else switch语句
	    在 NSLocalizedString 宏中使用换行字符串

##### Command click
	按住Command点击方法，类，变量等，交互方式比之前更加清晰;
		之前: Command +单击, 直接Jump to Definition;
		Xcode9: Control + Command + 单击
		鼠标用户: 对准你的对象，Command+鼠标右键
		触摸板用户: 对准你的对象, Command+双指点击 
		若恢复之前: 设置 / Navigation / Command-click on code 选择
	
	Command +/- 编辑器放大/缩小
	
	折叠代码:
	之前:
	局部折叠（折叠一个函数）:Command+Option+Left/Right
	全局折叠（折叠当前文件下的全部函数）: Shift+Command+Option+Left/Right
	折叠注释块：（/* */之间的文字）:Ctrl+Shift+Command+Left/Right 
	Xcode9:
	Command Click 后, 选择 Fold,可以用来折叠方法.

##### other
	编辑文本时，键入左边分隔符后将在当前的结尾处添加匹配的结尾分隔符。自动匹配分隔符包括“”、（）、[ ]，{ };
	
	Preference“字体和颜色”窗口增加了对行间距和光标样式的修改;
	
	MarkDown格式支持
	
#### @Folder / Group 和 Finder同步
	之前: 在Xcode中创建文件夹或重命名, Finder不同步
	Xcode9: 
	重名命Folder, Finder同步改变;
	默认在Xcode创建文件夹, 会同步Finder, 创建真实文件夹;
	若想建立虚拟group, 选择New Group without Folder 即可!
	真实group和虚拟group, 后者图标左下角有个小的三角形;


枚举值->字符串映射
![](http://ohlkc37yo.bkt.clouddn.com/20170917150563080556358.jpg?imageView2/0/format/jpg)

#### @xcassets

	xcassets可设置命名颜色, 在代码和IB中都可方便引用;
	支持高效的图像格式,包括.avci, .heic, and .heif文件扩展名. 

	右键选择添加New Color Set, 点击Any，在右侧区域中设置颜色;
	代码设置: 使用UIColor(named:) 新方法引用你的颜色; 
	UIColor *customColor;
    // colorNamed: iOS11, 要进行版本判断.
    if (@available(iOS 11, *)) { 
        customColor = [UIColor colorNamed:@"自定义颜色的文件名字"]; 
    } else {
        customColor = [UIColor colorWithRed:1 green:0.5 blue:1.0 alpha:1.0];
    }
	
IB设置如下:
![](https://static.oschina.net/uploads/space/2017/0610/113750_bVTy_2279344.png)
	

#### @Interface Builder:

	在运行时UIView布局会有一个选项在Size检查器中,用于左右间距遵循RTL语言.
	
	在iOS11中添加的基线与基线之间约束，该更新基于动态类型大小的变化来更新间距.
	
	Interface Builder现在以与运行时相同的方式呈现画布上的导航栏、选项卡条和工具栏.
	    
	使用Interface Builder中的NSTableView的usesAutomaticRowHeights属性，选择“自动（自动布局）”从尺寸检验器和设置行高值。该值用作自动布局计算的一部分.
	
	当视图的约束导致局部问题时，Interface Builder会发出警告,如截断和裁剪时.
	
	Interface Builder不再支持iOS 6。但是旧的部署目标文件还是可以查看的，他们的框架会被转换到iOS 7及以后的版本.
	
	UIViewController中Interface Builder使用UIView.safearealayoutguide代替被废弃的顶部和底部布局指示器。要使用新的安全区域，请在view controller的文件检查器中选择SafeArea Layout Guides，然后在内容和新的安全区域锚之间添加约束。这可以防止你的内容被顶部和底部的bars和过扫描区tvOS的遮蔽。部署到早期版本的iOS时，将安全区域的约束转换为顶部和底部.
	
	在iOS11中Interface Builder支持设置符合UITextInputTraits协议类的textContentType。可以自动填充适当的数据，包括的用户名和密码.
	
	当选择一个约束时，检查器现在允许选择一个不同目标来锚定它。根据约束类型，可以使用siblings和containers,自动更新约束以确定当前位置.


---
## <a id="Bug">Bug</a>
#### 意外警告
彻底关闭 This block declaration is not a prototype
Insert ‘void’ 警告
临时方案: Build Settings -> Strict Prototypes 设置为NO即可;


#### 使用CocoaPods的Xcode工程,在iOS11版的手机上AppIcon不显示
原因是CocoaPods的资源编译脚本在iOS11下出了点问题.需要修改脚本.  
两种修改方式:  
1.在Podfile添加脚本修改：  
  在Podfile 添加如下代码, 将[工程名] 换成自己工程的名称. 然后运行 `pod install`

	post_install do |installer|
	    copy_pods_resources_path = "Pods/Target Support Files/Pods-[工程名]/Pods-[工程名]-resources.sh"
	    string_to_replace = '--compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"'
	    assets_compile_with_app_icon_arguments = '--compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}" --app-icon "${ASSETCATALOG_COMPILER_APPICON_NAME}" --output-partial-info-plist "${BUILD_DIR}/assetcatalog_generated_info.plist"'
	    text = File.read(copy_pods_resources_path)
	    new_contents = text.gsub(string_to_replace, assets_compile_with_app_icon_arguments)
	    File.open(copy_pods_resources_path, "w") {|file| file.puts new_contents }
	end

2.手动修改

打开工程目录下:[工程名]/Pods/Target Support Files/Pods-[工程名]/Pods-[工程名]-resources.sh这个文件,替换最后一段代码:

修改前:

	 printf "%s\0" "${XCASSET_FILES[@]}" | xargs -0 xcrun actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${!DEPLOYMENT_TARGET_SETTING_NAME}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
	fi

修改后:

	printf "%s\0" "${XCASSET_FILES[@]}" | xargs -0 xcrun actool --output-format human-readable-text --notices --warnings --platform "${PLATFORM_NAME}" --minimum-deployment-target "${!DEPLOYMENT_TARGET_SETTING_NAME}" ${TARGET_DEVICE_ARGS} --compress-pngs --compile "${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}" --app-icon "${ASSETCATALOG_COMPILER_APPICON_NAME}" --output-partial-info-plist "${BUILD_DIR}/assetcatalog_generated_info.plist"
	fi

然后重新运行工程即可.



---
### 摘自部分文章:  
[简书App适配iOS 11](http://www.jianshu.com/p/26fc39135c34)

[iOS 11 安全区域适配总结](http://www.jianshu.com/p/efbc8619d56b)

[Xcode9新特性介绍-中文篇](http://www.cnblogs.com/yajunLi/p/7081150.html)

[带你快速浏览Xcode 9新特性](http://www.sohu.com/a/147172918_163917)

[Xcode9 新特性](https://my.oschina.net/Misayalvyuan/blog/918381)

