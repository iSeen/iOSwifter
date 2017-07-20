## 目录
[UI](#UI)  
[Code](#Code)  
[Tool](#Tool)

## <a id="UI"></a>UI

### UIStatusBar
	本来我的statusbar是lightcontent的，结果用UIImagePickerController会导致我的statusbar的样式变成黑色，怎么办？
	- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
	    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
	}

### UINavigationBar
	怎么把我的navigationbar弄成透明的而不是带模糊的效果？
	[self.navigationBar setBackgroundImage:[UIImage new]
	                         forBarMetrics:UIBarMetricsDefault];
	self.navigationBar.shadowImage = [UIImage new];
	self.navigationBar.translucent = YES;

    怎么像safari一样滑动的时候隐藏navigationbar?
	navigationController.hidesBarsOnSwipe = Yes

### UINavigationItem 
	自定义leftBarbuttonItem左滑返回手势失效
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                         initWithImage:img
                                         style:UIBarButtonItemStylePlain
                                         target:self
                                         action:@selector(onBack:)];
	self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;

	导航条返回键带的title太讨厌了,怎么让它消失!
	[[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];

### UIViewController
	点击self.view 键盘收起
	[self.view endEditing:YES];

### UIView
	使用view的缩放的时候，layer.border.width随着view的放大，会出现锯齿化的问题，解决这个问题需要设置这个属性。
	self.layer.allowsEdgeAntialiasing = YES;
	

### UIScrollView 
	ScrollView不能在viewController划到顶
	self.automaticallyAdjustsScrollViewInsets = NO;

### UITableView
	self.tableView.tableFooterView = [[UIView alloc] init];
	
	调整separaLine的位置
	myTableView.separatorInset = UIEdgeInsetsMake(0, 100, 0, 0);
	
	调整Cell右边对勾的颜色
	myTableView.tintColor = [UIColor redColor];

### UIImage
	imageWithContentsOfFile方法不能加载Assets.xcassets里的图片

	拉伸图片的时候怎么才能让图片不变形
	1.UIImage *xImage = [[UIImage imageNamed:@"xxx"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
	deprecated的方法: UIImage *image = [[UIImage imageNamed:@"xxx"] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
	2.打开图片, 更改设置start 

	神器计算图片位置的函数 AVMakeRectWithAspectRatioInsideRect（）(需导入AV框架)
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 300, 300)];
	imageView.center = self.view.center;
	imageView.backgroundColor = [UIColor redColor];
	imageView.contentMode = UIViewContentModeScaleAspectFit;
	UIImage *image = [UIImage imageNamed:@"mm.jpg"];
	imageView.image = image;
	 CGRect iamgeAspectRect = AVMakeRectWithAspectRatioInsideRect(image.size, imageView.bounds);
	NSLog(@"iamgeAspectRect = %@, imageView =%@",NSStringFromCGRect(iamgeAspectRect),NSStringFromCGRect(imageView.frame));
	[self.view addSubview:imageView];


### UILabel
判断label当前有几行

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(90, 90, 80, 100)];
    [self.view addSubview:label];
    label.text = @"33431dfadfdafadsfasfsdf";
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:13];

    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:13]};
    // 总高度
    CGFloat totalHeight = [label.text  boundingRectWithSize:label.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.height;
    // 每行文字的高度
    CGFloat lineHeight = label.font.lineHeight;
    // 行数 = 总高度除以每行高度
    NSInteger lineCount = totalHeight / lineHeight;
    NSLog(@"lineCount:%ld",lineCount);


### UITextField
	改变uitextfield placeholder的颜色和位置
	继承uitextfield，重写这个方法
	- (void) drawPlaceholderInRect:(CGRect)rect {
	    [[UIColor blueColor] setFill];
	    [self.placeholder drawInRect:rect withFont:self.font lineBreakMode:UILineBreakModeTailTruncation alignment:self.textAlignment];
	}


### NSTimer
NSTimer可以设置的最小时间间隔是[0.01s](https://stackoverflow.com/questions/44744939/whats-the-minimum-valid-time-interval-of-an-nstimer)  

	让timer不因scrollView的滚动而停止
	[[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

### Animation
使用CABasicAnimation，按home键后再切回来动画停止的解决方法：

	animation.removedOnCompletion = NO;
	
### CGPoint
	 如果一个矩形如果做了平移旋转缩放等一系列操作之后，上下左右的四个点（甚至矩形上任意一个点）的位置.
	CGPoint originalCenter = CGPointApplyAffineTransform(_mStyleLeftEyeView.center,
	                                                     CGAffineTransformInvert(_mStyleLeftEyeView.transform));
	//1左眼内眼角
	CGPoint bottomRight = originalCenter;
	bottomRight.x += _mStyleLeftEyeView.bounds.size.width / 2;
	bottomRight.y += _mStyleLeftEyeView.bounds.size.height / 2;
	bottomRight = CGPointApplyAffineTransform(bottomRight, _mStyleLeftEyeView.transform);


### UISwipegesture
	能不能只用一个pan手势来代替UISwipegesture的各个方向?
	- (void)pan:(UIPanGestureRecognizer *)sender
	{
	typedef NS_ENUM(NSUInteger, UIPanGestureRecognizerDirection) {
	    UIPanGestureRecognizerDirectionUndefined,
	    UIPanGestureRecognizerDirectionUp,
	    UIPanGestureRecognizerDirectionDown,
	    UIPanGestureRecognizerDirectionLeft,
	    UIPanGestureRecognizerDirectionRight
	};
	static UIPanGestureRecognizerDirection direction = UIPanGestureRecognizerDirectionUndefined;
	switch (sender.state) {
	    case UIGestureRecognizerStateBegan: {
	        if (direction == UIPanGestureRecognizerDirectionUndefined) {
	            CGPoint velocity = [sender velocityInView:recognizer.view];
	            BOOL isVerticalGesture = fabs(velocity.y) > fabs(velocity.x);
	            if (isVerticalGesture) {
	                if (velocity.y > 0) {
	                    direction = UIPanGestureRecognizerDirectionDown;
	                } else {
	                    direction = UIPanGestureRecognizerDirectionUp;
	                }
	            }
	            else {
	                if (velocity.x > 0) {
	                    direction = UIPanGestureRecognizerDirectionRight;
	                } else {
	                    direction = UIPanGestureRecognizerDirectionLeft;
	                }
	            }
	        }
	        break;
	    }
	    case UIGestureRecognizerStateChanged: {
	        switch (direction) {
	            case UIPanGestureRecognizerDirectionUp: {
	                [self handleUpwardsGesture:sender];
	                break;
	            }
	            case UIPanGestureRecognizerDirectionDown: {
	                [self handleDownwardsGesture:sender];
	                break;
	            }
	            case UIPanGestureRecognizerDirectionLeft: {
	                [self handleLeftGesture:sender];
	                break;
	            }
	            case UIPanGestureRecognizerDirectionRight: {
	                [self handleRightGesture:sender];
	                break;
	            }
	            default: {
	                break;
	            }
	        }
	        break;
	    }
	    case UIGestureRecognizerStateEnded: {
	        direction = UIPanGestureRecognizerDirectionUndefined;   
	        break;
	    }
	    default:
	        break;
	}
	}


### Instrument
	最快速的提升流畅度的方法
	用instrument找出所有不需要透明但是透明的view,layer.全部弄成不透明的.
	Profile / Core Animation / 选中Color Blended Layers 运行查看
	红色或者深红色的就是透明的层和view,他们就是拖慢你fps的罪魁祸首,如果不需要透明的就改掉.



## <a id="Code"></a> Code
### 三目写法: 

	NSString *b = a ?: @"222";  // a若为nil, b = @"222";

### 定义常量
	第一种: (检测字符串的值是否相等的时候更快)
	//.h
	FOUNDATION_EXPORT NSString * const kMyConstantString;
	//.m
	NSString * const kMyConstantString = @"Hello";
	可以直接使用(stringInstance == MyFirstConstant)来比较, 比较的是指针地址

	第二种
	#define kMyConstantString @"Hello"
	([stringInstance isEqualToString:MyFirstConstant]) 比较字符串的每一个字符是否相等

### CGFloat & float
64位系统下, CGFloat是double类型,32位系统下是float类型. CGFloat能够保证你的代码在64位系统下也不容易出错,所以你的代码应该尽量使用CGFloat.尽管他可能造成一些多余的消耗.不过能保证安全.


### static void *CapturingStillImageContext = &CapturingStillImageContext;
	这种声明方式常用于kvo,用来当做contenxt的key来添加.例如:
	[self addObserver:self forKeyPath:@"stillImageOutput.capturingStillImage" options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew) context:CapturingStillImageContext];
	这种声明方式可以导致a method to create a unique pointer at compile time.在编译的时候创建一个唯一的指针.因为kvo的时候context如果不小心重复了,会发生奇怪的事情.用这种方式可以避免.

### static inline function

如果你的.m文件需要频繁调用一个函数,可以用static inline来声明,这相当于把函数体当做一个大号的宏定义.不过这也不是百分之百有效,到底能不能把函数体转换为大号宏定义来用要看编译器心情,它要是觉得你的方法太复杂,他就不转了.他直接调用函数.

	类似这种简单函数他肯定是乐意的
	static inline CGRect ScaleRect(CGRect rect, float n)


## <a id="Tool"></a> Tool
[Charles iOS抓包Https](http://www.jianshu.com/p/ebeb5b8925c6)  
[AppStore截图尺寸要求](http://www.jianshu.com/p/2cad8f5ca63d)


	IQKeyboardManager 键盘管理
	KMCGeigerCounter 检测App流畅度帧数
	MagicRecord  替换CoreData
	CSStickyHeaderFlowLayou  CollectionView 实现tableview那种悬停的header
	FLAnimatedImage  防止播放GIF的时候卡顿
	SVPullToRefresh 一句话添加上拉刷新