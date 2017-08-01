# [CocoaPods](https://guides.cocoapods.org/syntax/podfile.html)

## 目录
[原理](#原理)  
[安装](#安装)    
[常用命令](#常用命令)  
[Podfile](#Podfile)  
[Private Spec Repo](#Private Spec Repo)  
[Carthage依赖管理](#Carthage依赖管理)  
[参考文章](#参考文章)

## <a id="原理"></a>原理
	将所有的依赖库都放到另一个名为Pods的项目中，然后让主项目依赖Pods项目，这样，源码管理工作都从主项目移到了Pods项目中。
	1.Pods 项目最终会编译成一个名为 libPods.a 的文件，主项目只需要依赖这个 .a 文件即可。
	2.对于资源文件，CocoaPods 提供了一个名为 Pods-resources.sh 的 bash 脚本，该脚本在每次项目编译的时候都会执行，将第三方库的各种资源文件复制到目标目录中。
	3.CocoaPods 通过一个名为 Pods.xcconfig 的文件来在编译时设置所有的依赖和参数。


## <a id="安装"></a>安装

### [Xcode](https://itunes.apple.com/cn/app/xcode/id497799835?mt=12)
### [Homebrew](http://brew.sh/)  软件管理器
安装:

	 ->  Press RETURN to continue or any other key to abort      出现这个回车  
	 ->  Password:     　　　　　　　               输入电脑开机密码  
	 ->  Downloading and installing Homebrew...  等待...  

使用:  

	搜索软件：brew search "软件名"
	安装软件：brew install "软件名"	
	卸载软件：brew remove "软件名"
	
### Ruby 面向对象的脚本语言
使用[RVM](http://www.rvm.io) (Ruby Version Manager: Ruby版本管理工具)安装

	$ curl -L get.rvm.io | bash -s stable   安装 RVM
	$ source ~/.rvm/scripts/rvm   指定源
	$ rvm -v    查询rvm版本号, 检查是否安装  
	$ rvm implode  rvm 删除
	
	$ rvm list 查询已安装的ruby  
	$ rvm list known 列出已知的ruby版本  
	$ rvm install [版本号]  安装一个ruby版本  
	$ rvm remove  [版本号]  卸载该版本ruby  
	$ rvm use ruby-2.4.0 --default 设置Ruby默认版本(重要!) 
	  或 $ rvm alias create default 2.0.0

	$ ruby -v 查看ruby版本  

### RubyGems (Mac自带)
简称 gems, 是一个用于对 Ruby组件进行打包的 Ruby 打包系统。 它提供一个分发 Ruby 程序和库的标准格式，还提供一个管理程序包安装的工具。  
安装:  
因taobao Gems源已停止维护，现由 ruby-china 提供镜像服务. [网站](https://gems.ruby-china.org/)

	gem sources -l  查看当前镜像
	gem sources --remove https://ruby.taobao.org/  移除现有Ruby默认源
	gem sources -a https://gems.ruby-china.org/    添加镜像或http镜像http://gems.ruby-china.org
	gem sources -l  验证Ruby镜像 (确保只有 gems.ruby-china.org)

	sudo gem update --system  升级gem 

### Cocoapods 依赖管理
#### Cocoapods安装:
	pod --version 查看当前安装版本号

	1)安装最新版本
	sudo gem install cocoapods  
	备注：苹果系统升级 OSX EL Capitan 后改为 sudo gem install -n /usr/local/bin cocoapods
	
	安装指定版本的CocoaPods
	sudo gem install cocoapods -v 1.1.1   
	或: sudo gem install -n /usr/local/bin cocoapods -v 1.1.1
	
	2)pod setup    将整个specs仓库clone下载到本地 ~/.cocoapods目录
	
	Ps:
	若耗时严重可参考以下方法更换CocoaPods镜像索引:
	所有项目的Podspec文件都托管在 https://github.com/CocoaPods/Specs,
	第一次执行pod setup时,CocoaPods会将这些podspec索引文件更新到本地的~/.cocoapods目录下, 这个索引文件比较大,所以第一次更新时非常慢.
	
	友好人士在国内的服务器建立了Cocoapods索引库的镜像, 所以执行索引跟新操作时候会快很多.具体操作方法如下:
	$ pod repo remove master
	$ pod repo add master https://gitcafe.com/akuandev/Specs.git
	$ pod repo update
	这是使用gitcafe上的镜像,将以上代码中的 https://gitcafe.com/akuandev/Specs.git 
	替换成 https://git.oschina.net/akuandev/Specs.git 即可使用oschina上的镜像。
	
	查看进度: 新窗口打开终端, 执行以下命令
	cd  ~/.cocoapods   
	du -sh * 
		
#### CocoaPods卸载 / 升级 / 安装指定版本:
卸载

	which pod                查看组件安装路径  
	sudo rm -rf (+组件安装路径)  移除组件  
	gem list | grep cocoapods  查看gems本地程序包中所有与cocoapods相关的已安装组件，然后挨个卸载
	sudo gem uninstall cocoapods 选择3卸载全部或Y，如果是单个版本直接卸载。
	(sudo gem uninstall cocoapods -v 0.39.0   删除指定版本号组件)
升级:		 
更新ruby

    官网下载最新版本 ruby: http://www.ruby-lang.org/en/downloads/
    在解压缩文件夹里进行编译
        ./configure
        sudo make
        sudo make install

		ruby -v  查看ruby 版本

更新Gem

	sudo gem update --system
	>>>>
	错误:
	ERROR:  While executing gem ... (Gem::Exception)
    Unable to require openssl, install OpenSSL and rebuild ruby (preferred) or use non-HTTPS sources
    解决:
    https://github.com/postmodern/ruby-install/issues/194
    brew install openssl
    rvm reinstall 2.3.0 --with-openssl-dir=`brew --prefix openssl`
    <<<<
    
	sudo gem install rubygems-update
	sudo update_rubygems
			 
安装最新版本或指定版本, 参考上面CocoPods安装.


## <a id="常用命令"></a>常用命令
	1、pod install
	根据Podfile文件指定的内容，安装依赖库，如果有Podfile.lock文件而且对应的Podfile文件未被修改，则会根据Podfile.lock文件指定的版本安装。
	每次更新了Podfile文件时，都需要重新执行该命令，以便重新安装Pods依赖库。
	2、pod update
	若果Podfile中指定的依赖库版本不是写死的，当对应的依赖库有了更新，无论有没有Podfile.lock文件都会去获取Podfile文件描述的允许获取到的最新依赖库版本。
	3、pod search  搜索本地保存的Pods依赖库tree
	4、pod setup
	用于跟新本地电脑上的保存的Pods依赖库tree.因每天有很多人会创建或者更新Pods依赖库，这条命令执行的时候会相当慢，还请耐心等待。我们需要经常执行这条命令，否则有新的Pods依赖库的时候执行pod search命令是搜不出来的。

注意:  
1. pod install 或 pod update 都会升级CocoaPods的spec仓库，加一个参数可省略这一步  
	
	pod install --verbose --no-repo-update  
	pod update --verbose --no-repo-update
	
2.工程在模拟器上编译报错，不支持i386，Cocoapods确实还不支持64位模拟器, [解决办法](http://stackoverflow.com/questions/19213782/undefined-symbols-for-architecture-arm64)
	
	1.build active architecture only 在debug的时候设置成YES，不要在release的时候用模拟器
	2.other linker flags 加一个 $(inherited)

Q1: Unable to find a specification for   

	 A1: 
    pod repo remove master  
    pod setup  


## <a id="Podfile"></a>Podfile
CocoaPods通过Ruby实现, Podfile也是通过ruby语法编写.

### Target configuration 此配置会使用和控制工程的生成.
	>> platform :ios, '8.0' 不指定平台版本(iOS/OS X/tvOS/watchOS), 则使用默认; ios三个字母都要小写，而且与前面的冒号之间不能有间隔，后面的版本号也可以不写，但是有些开源库对版本是有要求的，比如要在6.0以上才能运行，遇到这样的开源库就需要写上版本号。
	>> project 'MyProject'     默认情况下是没有指定的，当没有指定时，会使用Podfile目录下与target同名的工程：
	>> workspace 'MyWorkspace' 指定workspace
	>> xcodeproj 'demo.xcodeporj' 指明用于哪个项目
	   >>> xcodeproj "/Users/ning/Desktop/CocoaPodsTest/CocoaPodsTest.xcodeproj"  若Podfile放在任意目录下, 需指定工程目录

	inhibit_all_warnings! 指定全局不显示警告信息  
	pod 'pop', '~> 2.1', :inhibit_warnings => true  指定某个库不显示警告信息

	use_frameworks!  要求生成的是framework而不是静态库

	source 指定pod的来源。默认使用CocoaPods官方的source。通常不添加。
	source 'https://github.com/CocoaPods/Specs.git' 


	> Hooks 勾子，与swizzling特性类似，在某些操作之前，先勾起，而且让它执行我们特定的操作.
	
	> plugin 指定在安装期间使用某插件
	
	> pre_install 当我们下载完成，但是还没有安装之时，会勾起来，然后可以通过pre_install指定要做的事，做完后才进入安装阶段。
	
		pre_install do |installer|
		  // do something
		end
	
	> post_install 当我们安装完成，但是生成的工程还没有写入磁盘之时，我们可以指定要执行的操作。如: 修改一些工程的配置.
	
		post_install do |installer|
		  installer.pods_project.targets.each do |target|
		    puts #{target.name}
		  end
		end
	
	
	> def 通过def命令来声明一个pod集, 优点:如果有多个target，而不同target之间并不全包含，那么可以通过这种方式来分开引入。宏名首字母不能大写!
	
	# 定义依赖宏
		def 'custom_Pods'
			pod 'IQKeyboardManagerSwift'
		end
	
	# 使用宏
		target 'CoderStars' do
			custom_Pods
		end
	
	
	> Podfile全局配置
	install! Podfile全局配置命令, 一般不常用


### 依赖管理三个命令
#### 1. pod 指定特定名称库的依赖.
	最新版本 pod 'pop'
	指定版本 pod 'pop', '0.9'
	
	pod中用于指定范围的符号: 
	pod 'AFNetworking'              //不显式指定依赖库版本，表示每次都获取最新版本
	pod 'AFNetworking', '2.0'       //只使用2.0版本
	pod 'AFNetworking', '> 2.0'     //使用高于2.0的版本
	pod 'AFNetworking', '>= 2.0'    //使用大于或等于2.0的版本
	pod 'AFNetworking', '< 2.0'     //使用小于2.0的版本
	pod 'AFNetworking', '<= 2.0'    //使用小于或等于2.0的版本
	pod 'AFNetworking', '~> 0.1.2'  //使用大于等于0.1.2但小于0.2的版本 (从指定版本到倒数第二位版本号升1为止)
	pod 'AFNetworking', '~> 0.1'    //使用大于等于0.1但小于1.0的版本
	pod 'AFNetworking', '~> 0'      //高于0的版本，写这个限制和什么都不写是一个效果，都表示使用最新版本
	
	
	使用本地库 
	pod 'Alamofire', :path => '~/Documents/Alamofire'


#### 2. podspec 提供简单的API来创建podspec
	// 不指定参数表示使用根目录下的podspec，默认开源库的podspec一般都会放在根目录下
	podspec
	// 如果podspec的名字与库名不一样，可以通过这样来指定
	podspec :name => 'MyPodspec'
	// 如果podspec不是在根目录下，那么可以通过:path来指定路径
	pod spec :path => '/Documents/PrettyKit/PrettyKit.podspec'
	
	2.1 通过仓库的podspec引入
	用仓库的master:
	pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire.git'
	用指定的分支
	pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire.git', :branch => 'dev'
	用指定的tag
	pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire.git', :tag => '3.1.1'
	用指定的提交版本
	pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire.git', :commit => '0f506b1c45'
	
	2.2 从外部podspec引入
	pod 'JSONKit', :podspec => 'https://example.com/JSONKit.podspec'


#### 3. target 通过target指定工程所依赖的范围, target块内可以有多个target子块.

	target 'ShowsApp' do
	
	pod 'ShowsKit'
	
	  #ShowsTV可以访问ShowsKit + ShowTVAuth，其中ShowsKit是继承于父层的
	  target 'ShowsTV' do
	  pod 'ShowTVAuth'
	  end
	
	  #ShowsTests可以访问Specta + Expecta
	  #同时也可以访问ShowsKit，它是明确指定继承于父层的所有pod
	  target 'ShowsTests' do
	  inherit! :search_paths
	  pod 'Specta'
	  pod 'Expecta'
	  end
	
	end
	
	使用link_with实现多个target中使用几个相同的Pods依赖库
	link_with 'FirstTarget', 'SecondTarget'
	pod 'xx'  
	pod 'yy'

### 备注
	=begin
	  //在Podfile添加多行注释
	=end
	
## <a id="Private Spec Repo"></a>Private Spec Repo
### 创建私有Spec Repo管理项目公共组件

	1.创建并设置一个私有的Spec Repo。
	2.创建Pod的所需要的项目工程文件，并且有可访问的项目版本控制地址。
	3.创建Pod所对应的podspec文件。
	4.本地测试配置好的podspec文件是否可用。
	5.向私有的Spec Repo中提交podspec。
	6.在个人项目中的Podfile中增加刚刚制作的好的Pod并使用。
	7.更新维护pod spec。


#### 一、创建私有 Spec Repo
	
	>> 查看本地 pod spec仓库
	$ pod repo
	或:
	$ cd ~/.cocoapods/repos
	$ ls 查看repos列表
	
	>> 新建 pod spec 仓库
	$ pod repo add [Private Repo Name] [Your GitHub HTTPS clone URL]
	pod repo add ZNSpecs https://github.com/iSeen/ZNSpecs.git
	
	>> 下载Cocoapods模板 (过程中会有一些选项，按需选择即可。模板下载完成后会自动打开工程。你会在Pods->Pods-> YourPod的目录先看见ReplaceMe.m的文件。该文件是无用的文件，可以将它删除，并编写你自己的代码。)
	$ pod lib create ZNPods
	项目目录结构:
	1.Podspec metadata：可更改 README 和 MyLibrary.podspec
	2.Example for PrivateRepo：可编写测试文件
	3.Tests：测试模块
	4.Development Pods：编写代码，用代码代替ReplaceMe.m文件
	5.Frameworks：
	若已写好库，想写测试模块或者测试demo的时候，首先进入Example文件夹执行pod update命令，打开工程包含 #import <ZNPods/XYZ.h>
	Ps:当你更改了Pod/Classes或者Pod/Assets或者更新了pod spec，你应该执行pod install命令或者 pod update。

	创建.podspec文件
	$ pod spec create ZNPods

	>> 本地检查.podspec合法性
	$ pod lib lint
	>> 远程检查.podspec合法性
	$ pod spec lint
	
	>> 将您的pod工程提交至仓库YourPodRepositoryURL
	新建一个标签（tag）为1.0。（与podspec里的版本保持一致）
	Ps:
	YourPodSpecRepositoryURL: 保存pod spec文件的仓库;  
	YourPodRepositoryURL: 保存pod工程的仓库.	
	>> 将pod spec文件提交至 私有spec仓库
	pod repo push YourPodSpecRepositoryName YourPod.podspec

#### 二. 使用私有pods
	新建一个工程并创建Podfile, pod search YourPod, pod install.

#### 三.坑	

	查看详细错误信息
	pod spec lint ZNPods.podspec --verbose
	
	? swift版本问题
	echo "3.0" > .swift-version
		
	? uninitialized constant REST Disconnected Error
	显示链接错误, 设置默认 rvm use ruby-2.3.4 --default
	
	? pod install [!] Unable to find a specification for xxx
	Podfile 文件加入两个: (不加source, 默认搜索官方, 加source, 取消默认)
	source 'https://github.com/CocoaPods/Specs.git'     #官方仓库地址
	source 'https://github.com/iSeen/ZNSpecs.git'       #私有仓库地址
	

## <a id="Carthage依赖管理"></a>Carthage依赖管理
优势:

	Carthage 是由 Swift 语言写的，只支持动态框架，只支持 iOS8+;  
	相比CocoaPods，Carthage不牵扯 Xcode 项目文件, 轻耦合，更灵活;  
	使用 xcodebuild 工具来编译依赖项目成二进制 Framework，再引入到项目中去。

使用:

	1.创建 Cartfile 文件，添加依赖库内容;
	2.执行 carthage update 命令, 拉取源代码并编译为 Framework;
	3.在项目中引入依赖的 Framkework: 只需要在对应 Target 中的 Build Setting 中的 Framework Search Path 项加入以下路径，Xcode 便会自动搜索目录下的 Framework：  
	$(SRCROOT)/Carthage/Build/iOS

文件说明:

	Cartfile 文件: 用来标注你需要哪些依赖库 (需要提交远程服务器)  
	Cartfile.resolved 文件: 用来跟踪项目当前所用的依赖版本号，为了保持多端开发一致 (需要提交到远程服务器)  
	Carthage 文件夹: 用来存放依赖库的源文件和编译后的文件 (不需要提交远程服务器)


## <a id="参考文章"></a>参考文章
[用CocoaPods做iOS程序的依赖管理](http://blog.devtang.com/2014/05/25/use-cocoapod-to-manage-ios-lib-dependency/)  
[Cocoapods版本更新](http://www.cnblogs.com/MJchen/p/6097278.html)

[Cocoa 新的依赖管理工具：Carthage](http://www.isaced.com/post-265.html)

[语义化版本 2.0.0](http://semver.org/lang/zh-CN/)

[使用私有Cocoapods仓库 中高级用法](http://www.jianshu.com/p/d6a592d6fced)  
[工程支持cocoapods](http://www.jianshu.com/p/8a7b9232cbab)  
[Cocoapods使用私有库中遇到的坑](http://www.jianshu.com/p/1e5927eeb341)





