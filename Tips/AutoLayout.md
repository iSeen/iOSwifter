# AutoLayout

## AutoLayout
	布局方式: Frame、Autoresizing Mask、Auto Layout，及 Mansory、SnapKit、PureLayout、CocoaUI 等第三方库;

	布局重点: 先大后小，先整体后局部，先不变后可变;

	layoutSubviews 负责布局，比如调整View之间的距离，大小;
	drawRect 负责绘制，比如使用什么颜色;
	
	AutoLayout 则是在layout之前增加了一个设定约束的过程,也就是update constraints;
	每个view的constraints数组中保存的实际上是layout 子view所需的约束的集合;

	在view的layoutSubView中，如果我们调用了[super layoutSubView] 系统就把设定的这些约束计算成每个view的bounds，center属性。当然我们也可以基于AutoLayout的结果,再做布局的调整。

	PS: 标准设计稿: 640 x 1136(iPhone5系列屏幕) 
	
	IB与相关文件做连接时关键字：
	IBOutlet
	IBAction
	IBOutletCollection(可以将界面上一组相同的控件连接到同一个数组中)

	通过代码添加Constraint开始使用Autolayout,需要对使用的View的translatesAutoresizingMaskIntoConstraints的属性设置为NO.否则View还是会按照以往的autoresizingMask进行计算.
	
	在Interface Builder中勾选了Ues Autolayout,IB生成的控件的translatesAutoresizingMaskIntoConstraints属性都会被默认设置NO.

### AutoLayout 关于更新部分方法的区别

    setNeedsLayout：告知页面需要更新，但是不会立刻开始更新。执行后会立刻调用layoutSubviews。
    layoutIfNeeded：告知页面布局立刻更新。所以一般都会和setNeedsLayout一起使用。如果希望立刻生成新的frame需要调用此方法，利用这点一般布局动画可以在更新布局后直接使用这个方法让动画生效。
    layoutSubviews：系统重写布局
    setNeedsUpdateConstraints：告知需要更新约束，但是不会立刻开始
    updateConstraintsIfNeeded：告知立刻更新约束
    updateConstraints：系统更新约束

	
### Align：用来设置对齐相关的约束；

	Leading Edges：头对齐
	Trailing Edges：尾对齐
	Top Edges：顶部对齐
	Bottom Edges：底部对齐
	
	Horizontal Centers：水平中心对齐
	Vertical Centers：垂直中心对齐
	BaseLines：基准线（默认 View 底部位置）水平对齐，用来对齐有文字的控件，如 UILabel、UIButton 等;
		
	Horizontal Center in Container：View 的水平中心和容器的水平中心的相对距离
	Vertical Center in Container：View 的垂直中心和容器的垂直中心的相对距离
	点击右侧下拉框可以选择“Use Current Canvas Value”，意思是使用当前 Xib/Storyboard 内的差值。
	
	None：不更新 frame
	Items of New Constraints：更新新添加的 frame
	All Frames in Container：更新容器内所有的 frame
	
	Aspect Ratio 宽高比

### Pin：设置相对大小和位置；
	可选项“Constrain to margins”，意思是在设置上述约束是相对于 margins 设置的，而 margin 默认距离是 16。
	
	Width：设置宽度
	Height：设置高度
	
	Equal Widths：设置两个同级 View 的宽度关系
	Equal Heights：设置两个同级 View 的高度关系
	Aspect Ratio：设置 View 自身宽高比例
	
	Align：和前面所讲的 **Align** 一致。那为什么 **Align** 还会出现在这边呢？估计和 **Pin** 有关系，故而也放到这边。

### Resolve Auto Layout Issues：解决 autolayout 问题；
	Update Frames：更新 frame 
	Update Constraints：更新约束
	Add Missing Constraints：添加遗漏的约束
	Reset to Suggested Constraints：重置约束
	Clear Constraints：清除约束

## SizeClass
[WWDC 2014 Session笔记 - iOS界面开发的大一统](https://onevcat.com/2014/07/ios-ui-unique)

	SizeClass 中文意思可以理解为尺寸等级，就是在 autolayout 的基础上，加上屏幕尺寸类型的定义。SizeClass 的宽高有三种类型：Compact（紧凑）、Any（任意）、Regular（普通）
![](https://github.com/iSeen/Resource/raw/master/Images/sizeClass.png)

现在的 iPad 不论横屏还是竖屏，两个方向均是 Regular 的；而对于 iPhone，竖屏时竖直方向为 Regular，水平方向是 Compact，而在横屏时两个方向都是 Compact。要注意的是，这里和谈到的设备和方向，都仅仅只是为了给大家一个直观的印象。相信随着设备的变化，这个分类也会发生变动和更新。Size Classes 的设计哲学就是尺寸无关，在实际中我们也应该尽量把具体的尺寸抛开脑后，而去尽快习惯和适应新的体系。


![](https://github.com/iSeen/Resource/raw/master/Images/install.png)

	Installed/UnInstalled 表示的意思是当前布局是否被安装在什么类型的屏幕上。
	Installed/UnInstalled 前面如果没有东西，表示布局是安装在 wAny|hAny 类型的屏幕上。
	现在如果我们要单独设置某种类型屏幕的布局可以点击加号，选择屏幕类型

![](https://github.com/iSeen/Resource/raw/master/Images/SelectIns.png)  

	将新的屏幕类型的勾选取消掉，则当前布局在该类型下不起作用，此时就可以切换类型，重新设置所有约束。
	若只想修改一条约束，也可以点击 Size Inspector, 双击任意一条约束，会出现一个和之前类似的界面;
	如果 Xcode 的 Inspector 一些选项前面有加号，就表明它可以被重写;

### Preview 预览功能
	点击 Xcode Tool Bar 的 Assistant Editor 按钮，显示另一个窗口;
	选择 Preview 展示预览界面;
	如果想在预览中同时显示不同类型的屏幕，可以在预览界面的左下角点击加号，选择更多设备;
	如果想要查看横屏/竖屏，点击设备下方的旋转按钮即可;



## 开发技巧

建议:
团队协作开发/独立开发, 请为每一个屏幕使用一个单独的 StoryBoard;

如何连接项目里面的不同的StoryBoard? 这里有两种方法:

    使用Xcode7中所提供的StoryBoard Reference方案
    通过代码来连接StoryBoard


开发注意:

	1.使用 StoryBoard 搭建框架，复杂的应用则通过 StoryBoard Reference 拆分模块，人数较多则考虑只用 xib 开发;
	2.通过 IB + Auto Layout 设计页面的大体布局;
	3.根据具体需求选择 Subview 的技术方案：
    静止页面， Auto Layout 拖拽生成。
    动效页面，看情况而定：
        渐隐渐现、拉长拉短，拖拽 Constraint 实现。
        飞来飞去、时有时无，则用代码实现。
	
细节:

	比如是否需要Runtime Attributes、 IBDesignable 、Size Class 、是用 IB 写 CustomeView 还是 drawRect 里写、是用 CALayer 还是用 UIView 实现动画、要不要考虑 ChildViewController 等;
	
设计理念:

    不同层次上，各个控件的层次关系
    相同层次上，各个控件的依赖关系
    设置关系时，如何选择最优的属性

StoryBoard 应用:

    如果一个人开发，那没什么问题，随便用。
    如果一个人负责几个页面，那问题也不大，用 Reference 将 StoryBoard 按照业务进行拆分即可。
    如果几个人开发几个页面，那建议考虑 xib ，只要一个页面在一段时间内只有一个人负责维护就行。
    如果几个人开发一个页面。呃，或许你们公司该裁人了。

手写代码和 IB 如何选择:

	1.IB 写的 View 可复用，不可以继承;
	2.对于复杂动效页面，一般是用 UIView 拖个坑位，然后用代码在里面通过 CALayer 实现动效;


### User Defined Rumtime Attributes  设置KVC属性值
	1. 添加layer属性: layer.borderWidth  layer.cornerRadius ...
	2. 要配置自定义的控件, 自定义一个叫name的属性那可以:  Key Path: name  String  xxx
	   在代码中获取你的自定义属性，你就可以: 
	   id value = [sender valueForKey:@"name"];
	3. Other Types
	要配置CALayer的 border coloer 和 shadow color，他们都是CGColorRef类型的，并不能直接在User Defined Runtime Attributes进行配置，但请看解决方案：
	为了兼容CALayer 的KVC ，你得给CALayer增加一个分类
	@implementation CALayer (Additions)
	- (void)setBorderColorFromUIColor:(UIColor *)color {
	  self.borderColor = color.CGColor;
	}
	@end	
![](http://img.blog.csdn.net/20140625143129703?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvemhvdTEyMTYxNDEwNzg=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

### IBDesignable & IBInspectable 组合实现动态刷新预览效果
	IB_DESIGNABLE
	宏的功能: 让XCode动态渲染出该类图形化界面;
	使用: 把该宏加在自定义类的前面, 然后IB设置继承类, Rumtime Attributes添加相关属性;
	
	IBInspectable
	功能: 让支持KVC的属性能够在Attribute Inspector中配置;
	使用: 添加属性, Set方法即可，如果是现有类，使用Category; 
		  然后IB右侧Attribute Inspector就会多出一个配置选项进行更改.
		  每次更改都会在Identity Inspector中改变一个rumtime的KVC变量;

	.h
	IB_DESIGNABLE
	@interface ZNIBDesignableView : UIView
	@property (nonatomic) IBInspectable CGFloat cornerRadius;
	@end
	
	.m
	@implementation ZNIBDesignableView
	- (void)setCornerRadius:(CGFloat)cornerRadius {
	    _cornerRadius = cornerRadius;
	    self.layer.cornerRadius = cornerRadius;
	}	
	@end
	

	PS: 如果不能动态刷新，重启XCode，如果还不能刷新，菜单栏Editor，建议开启Automatically Refresh Views;


### 手写Autolayout 的位置
	如果是在自定义view中，写在init方法中。
	如果是在ViewController中，写在 - (void)viewDidLoad()中。
	
	为什么不能写在viewDidAppear或者viewWillAppear中？
	viewDidLoad是可以保证在整个生命周期只出现一次的,为了避免约束重复添加，所以你应该在viewDidLoad中添加。


### Intrinsic Content Size 固有内容大小
	每一个View 都有一个特别的属性叫做Intrinsic Content Size，可以理解成是一个View的最合适而且最小的宽度和高度。
	对于UILabe来说，就是至少得把我设定的文字都显示完整吧，所以系统只需要知道UILabel的位置。
	而UIView的Intrinsic Content是（0，0）所以需要设置UIView的宽高（或是设定周围的边距等等其他关系可以让系统知道这个View应该多宽，多高）;
	
	对应的系统方法就是 - (CGSize)intrinsicContentSize;
	
	UIbutton UIlabel 因为固有内容,可以不添加宽高约束;
	UIView 没有固有内容, 需要添加宽高约束, 如果不想添加宽高约束, 解决如下
	1.代码约束: 需在 - (CGSize)intrinsicContentSize 指定默认大小;
	若期望UILabel的大小总是比内容宽高都大一些:
	创建一个继承于UILabel的自定义试图，然后重写以下方法:
	- (CGSize)intrinsicContentSize {
	    CGSize originalSize = [super intrinsicContentSize];
	    CGSize size = CGSizeMake(originalSize.width+20, originalSize.height+20);
	    return size;
	}
	
	2.Xib约束: 需在右侧约束设置下面的Instrinsic Size的属性设置为Placeholder, Xcode就不会报错.


### Content Hugging Priority和Content Compression Resistance
	“Content Hugging Priority”，也叫内容紧靠优先级（小名：别扯我），该优先级越高，这越晚轮到被拉伸。 设置view 有多大愿意（优先级），愿意显示里面内容之外的部分。
	“Content Compression Resistance Priority”，也叫内容压缩阻力优先级（小名：别挤我），该优先级越高，则越晚轮到被压缩。 设置view有多大意愿（优先级），愿意压缩里面的内容。

### 代码布局
    1.
    yellowView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    yellowView.frame = CGRectInset(redView.bounds, 20, 20);
    2.
    - (void)layoutSubviews {
	    yellowView.frame = CGRectInset(self.bounds, 20, 20);
	    [super layoutSubviews];
	}

### 代码更改Xib添加的约束
	当使用代码来修改约束时，只能修改约束的常量值constant。一旦创建了约束，其他只读属性都是无法修改的，特别要注意的是比例系数multiplier也是只读的。
	
	1.和拉线其他视图一样, 约束也可以拉线.
	@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeight;
	
	_constraintHeight.constant = 150;
    [self setNeedsLayout];
    [self layoutIfNeeded];

	2.不拉线更改约束
	在superview的constraints属性中查找，如果发现firstItem和firstAttribute属性分别是date picker view和top，则该constraint即为目标约束，然后修改其constant属性。
	
	- (void)replacePickerContainerViewTopConstraintWithConstant:(CGFloat)constant {  
        for (NSLayoutConstraint *constraint in self.pickerContainerView.superview.constraints) {  
            if (constraint.firstItem == self.pickerContainerView && constraint.firstAttribute == NSLayoutAttributeTop) {  
                constraint.constant = constant;  
            }  
        }  
    }  


### 查看两个视图距离
先选中一个视图,  按住option键并将鼠标移动到其他视图上

### 为视图添加辅助线
	添加  
	选中某个View,
	shift+Command+ "-" 添加横向辅助线
	shift+Command+ "|" 添加纵向辅助线，添加的位置都是左右/上下居中的
	
	移动
	光标移动到线上时会出现可拖动的按钮，按住左右/上下拖动到想要的位置，拖动时可以看到辅助线线距离视图左右/上下的距离
	
	删除
	方式也很简单，与删除断点方式一样，快速拖动到视图看不见的地方即可删除.
	
### 将多个view视图合并到一个视图层级
	子View已经调整好
	1.将子View拖动到父视图上, 无需重新调整, 选中这些控件，选择菜单栏上 Editor->Embed in->View/Scroll view, 最终控件还是按照原来样式排列在一个view上.
	2.从父类view上移到另一个视图，选择Editor->Unembed 就可以.

	
### UIScrollView 布局 (ContentSize复杂性)
	1.添加UIScrollView约束, 上下首尾为0;
	2.在UIScrollView上添加一个containerView作为唯一子视图的内容视图, 子视图添加到containerView上, 并添加containerView约束,上下首尾为0(报错先不修复);
	3.将containerView添加如下约束:
	若支持垂直滚动添加: Horizontal Center in Container, 并固定containerView高度, 若想动态修改, 拖拽高度约束后,代码更改;
	若支持水平滚动添加: Vertical Center in Container, 并固定containerView宽度, 若想动态修改, 拖拽宽度约束后,代码更改;




## Masonry
### 基本使用
	使用 mas_makeConstraints方法的元素必须先添加到父视图, 再进行约束.
	mas_makeConstraints 内部无需弱引用self

	mas_makeConstraints:添加约束
	mas_updateConstraints：更新约束、亦可添加新约束
	mas_remakeConstraints：重置之前的约束
	
	priorityLow()设置约束优先级

等价概念:  

	1.leading与left  trailing与right 在正常情况下是等价. 一般只用left和right,  用leading/trailing 后就不要用left/right，如果混用会出现崩溃.
	2.mas_equalTo:  比equalTo多了类型转换操作, 适合用于数值元素
	equalTo: 用于对象或是多个属性的处理, 尤其多个属性时，必须使用equalTo,例如 make.left.right.equalTo(self.view);

	
// 设置view的宽高比:

	multipliedBy属性: 表示约束值为约束对象的乘因数
	dividedBy属性表示: 约束值为约束对象的除因数

	// 进行屏幕的适配的时候，往往需要根据屏幕宽度来适配一个相应的高度，在此推荐使用如下约束的方式来进行控件的适配
	[self.topView addSubview:self.topInnerView];
	[self.topInnerView mas_makeConstraints:^(MASConstraintMaker *make) {
	    make.height.equalTo(self.topView.mas_height).dividedBy(3);
	    make.width.and.height.lessThanOrEqualTo(self.topView);
	    make.width.and.height.equalTo(self.topView).with.priorityLow();
	    make.center.equalTo(self.topView);
	}];

全局宏的使用:
    
    #define MAS_SHORTHAND_GLOBALS 使用全局宏定义，可以使equalTo等效于mas_equalTo
    #define MAS_SHORTHAND 使用全局宏定义, 可以在调用masonry方法的时候不使用mas_前缀
	'#import "Masonry.h"' 头文件一定放在宏的后面;  

	// 当使用了这个全局宏定义之后，发现可以有个类`NSArray+MASAdditions.h`，看了之后发现可以
	self.buttonViews = @[raiseButton, lowerButton, centerButton];
	// 之后可以在updateConstraints 方法中
	- (void)updateConstraints {
	   [self.buttonViews updateConstraints:^(MASConstraintMaker *make) {
	        make.baseline.equalTo(self.mas_centerY).with.offset(self.offset);
	    }];
	    [super updateConstraints];  
	}

部分写法:  

	距离self.view上下左右30
	make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(30, 30, 30, 30));    

	multipliedBy使用只能是设置同一个控件
	[self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {  
	      make.height.equalTo(self.titleLabel.mas_width).multipliedBy(3); 
	}];


动态修改视图约束:

	// 创建视图约束
	[blueView mas_makeConstraints:^(MASConstraintMaker *make) {
	      self.animatableConstraint = make.edges.equalTo(superview).insets(paddingInsets).priorityLow();
	]];
	// 更改约束 （另一处方法中）
	UIEdgeInsets paddingInsets = UIEdgeInsetsMake(padding, padding, padding, padding);
	self.animatableConstraint.insets = paddingInsets；
	[self layoutIfNeeded];


debug模式：约束控件发生冲突, 可设置View的key定位:
	
	// 对某个view添加key值
	greenView.mas_key = @"greenView";
	// 或者如下顺序
	MASAttachKeys(greenView, redView, blueView, superview);
	// 同样的对每条约束亦可以添加key
	make.height.greaterThanOrEqualTo(@5000).key(@"ConstantConstraint");


preferredMaxLayoutWidth: 多行label的约束问题
 
	// 已经确认好了位置
	// 在layoutSubviews中确认label的preferredMaxLayoutWidth值
	- (void)layoutSubviews {
	    [super layoutSubviews];
	    // 你必须在 [super layoutSubviews] 调用之后，longLabel的frame有值之后设置preferredMaxLayoutWidth
	    self.longLabel.preferredMaxLayoutWidth = self.frame.size.width-100;
	    // 设置preferredLayoutWidth后，需要重新布局
	    [super layoutSubviews];
	}



scrollView使用约束的问题：原理通过一个contentView来约束scrollView的contentSize大小，也就是说以子控件的约束条件，来控制父视图的大小

	// 1. 控制scrollView大小（显示区域）
	[self.scrollView makeConstraints:^(MASConstraintMaker *make) {
	     make.edges.equalTo(self.view);
	}];
	// 2. 添加一个contentView到scrollView，并且添加好约束条件
	[contentView makeConstraints:^(MASConstraintMaker *make) {
	     make.edges.equalTo(self.scrollView);
	     // 注意到此处的宽度约束条件，这个宽度的约束条件是比添加项
	     make.width.equalTo(self.scrollView);
	}];
	// 3. 对contentView的子控件做好约束，达到可以控制contentView的大小



新方法：2个或2个以上的控件等间隔排序

	/**
	 *  多个控件固定间隔的等间隔排列，变化的是控件的长度或者宽度值
	 *
	 *  @param axisType        轴线方向
	 *  @param fixedSpacing    间隔大小
	 *  @param leadSpacing     头部间隔
	 *  @param tailSpacing     尾部间隔
	 */
	- (void)mas_distributeViewsAlongAxis:(MASAxisType)axisType 
	                    withFixedSpacing:(CGFloat)fixedSpacing l
	                          eadSpacing:(CGFloat)leadSpacing 
	                         tailSpacing:(CGFloat)tailSpacing;
	
	/**
	 *  多个固定大小的控件的等间隔排列,变化的是间隔的空隙
	 *
	 *  @param axisType        轴线方向
	 *  @param fixedItemLength 每个控件的固定长度或者宽度值
	 *  @param leadSpacing     头部间隔
	 *  @param tailSpacing     尾部间隔
	 */
	- (void)mas_distributeViewsAlongAxis:(MASAxisType)axisType 
	                 withFixedItemLength:(CGFloat)fixedItemLength 
	                         leadSpacing:(CGFloat)leadSpacing 
	                         tailSpacing:(CGFloat)tailSpacing;
	
	使用方法很简单，因为它是NSArray的类扩展：
	
	//  创建水平排列图标 arr中放置了2个或连个以上的初始化后的控件
	//  alongAxis 轴线方向   固定间隔     头部间隔      尾部间隔
	[arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:5 tailSpacing:5];
	[arr makeConstraints:^(MASConstraintMaker *make) {
	       make.top.equalTo(@60);
	       make.height.equalTo(@60);
	}];


当你的所有约束都在 updateConstraints 内调用的时候，你就需要在此调用此方法，因为 updateConstraints方法是需要触发的

	// 调用在view 内部，而不是viewcontroller
	+ (BOOL)requiresConstraintBasedLayout {
	    return YES;
	}
	
	/**
	 *  苹果推荐 约束 增加和修改 放在此方法种
	 */
	- (void)updateConstraints {
	    [self.growingButton updateConstraints:^(MASConstraintMaker *make) {
	        make.center.equalTo(self);
	        make.width.equalTo(@(self.buttonSize.width)).priorityLow();
	        make.height.equalTo(@(self.buttonSize.height)).priorityLow();
	        make.width.lessThanOrEqualTo(self);
	        make.height.lessThanOrEqualTo(self);
	    }];
	    //最后记得回调super方法
	    [super updateConstraints];
	}

如果想要约束变换之后实现动画效果，则需要执行如下操作

    // 通知需要更新约束，但是不立即执行
    [self setNeedsUpdateConstraints];
    // 立即更新约束，以执行动态变换
    // update constraints now so we can animate the change
    [self updateConstraintsIfNeeded];
    // 执行动画效果, 设置动画时间
    [UIView animateWithDuration:0.4 animations:^{
       [self layoutIfNeeded];
    }];

获取masonry布局控件的frame, 调用其父控件的layoutIfNeeded方法。




