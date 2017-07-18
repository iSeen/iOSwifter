# RxSwift

[官方地址](https://github.com/ReactiveX/RxSwift)  
[RxSwift Community 开源组件](https://github.com/RxSwiftCommunity)

## Why
GUI 编程比较复杂的三个部分：

    非原生UI效果实现
    大量状态的维护 ->  可通过单向数据流来解决（结合 Immutable Data）
    异步数据处理  ->  可通过 RxSwift / ReactiveCocoa 解决

## What
RxSwift是一个针对于Swift语言的响应式编程框架，旨在使异步操作和事件/数据流的实现变的简单。可以统一处理 Delegate, KVO, Notification，可以绑定 UI，方便网络请求的处理等.

#### 😊MVVM架构 + 响应式编程 + Swift  
ViewController:   
尽量不涉及业务逻辑，让 ViewModel 去做. 只是一个中间人，接收 View 的事件、调用 ViewModel 的方法、响应 ViewModel 的变化.

ViewModel:

	处理业务逻辑
	网络请求获取数据, 传递数据源, 控制器实现回调. 也可使用通知或闭包实现回调.
	不能包含 View，不然就跟 View 产生了耦合，不方便复用和测试;
	之间可以有依赖;
	避免过于臃肿，不然维护起来也是个问题;

#### 😊概念
RxSwift中四个重要的角色:

##### 1.Observable 被观察者  "水管"
类似于ReactiveCocoa中的Signal 和 SignalProducer, 里面装有事件流，供Observer订阅.  
事件流在Rx中与ReactiveCocoa一样具有三类：

	.Next(value) 处理新收到的值
	.Completed 标记整个流已经完成，取消所有观察者的订阅
	.Error 处理一个错误，结束整个流，对所有的观察者取消订阅

流程：先把 Native Object 变成 Observable，再通过 Observable 内置的各种强大的转换和组合能力变成新的 Observable，最后消费新的 Observable 的数据。

![](http://ohlkc37yo.bkt.clouddn.com/201702176280514814540314644.jpg)

##### 2. Observer  观察者
UIBindingObserver: 是一个观察者，用于对UI的绑定.

##### 3.Disposable 资源释放类

##### 4.Scheduler 线程相关类
默认代码都是在当前线程中执行，如果要手动切换线程，可以使用 subsribeOn 和 observeOn两种.
     
     subscribeOn: 跟位置无关，无论在链式什么地方调用，Observable 和 subscription 都会受影响；
     observeOn(常用): 仅对之后的调用产生影响.


### Subject 水龙头
既可以订阅其他 Observable 对象，同时又可以对它的订阅者们发送事件.

`PublishSubject `: 会发送订阅者从订阅之后的事件序列。

`ReplaySubject `: 在新的订阅对象订阅的时候会补发所有已经发送过的数据队列， bufferSize 是缓冲区的大小，决定了补发队列的最大值。如果 bufferSize 是1，那么新的订阅者出现的时候就会补发上一个事件，如果是2，则补两个，以此类推。

`BehaviorSubject `: 在新的订阅对象订阅的时候会发送最近发送的事件，如果没有则发送一个默认值。

`Variable ` 是基于 BehaviorSubject 的一层封装，它的优势是：不会被显式终结。即：不会收到 .Completed 和 .Error 这类的终结事件，它会主动在析构的时候发送 .Complete 。  
RxSwift特有类型, 泛型, 其.value属性指向的就是它的实际参数类型.  
只要改变value的值，就会发射改变后的数据.  
ViewModel改变其值, 控制器就能监听进行刷新操作.

### Transform 转换
对一个 Observable 的数值做一些转换，然后产出新的值，依旧是一个 Observable. 类似于 Swift 中 CollectionType 的各种转换.

`map `就是对每个元素都用函数做一次转换，挨个映射一遍。

`flatMap ` 
在 Swift 中，我们可以用 flatMap 过滤掉 map 之后的 nil 结果。  
在 Rx 中，flatMap 可以把一个序列转换成一组序列，然后再把这一组序列『拍扁』成一个序列。

`scan `有点像 reduce ，它会把每次的运算结果累积起来，作为下一次运算的输入值。


### Filtering 过滤
对 Observable 传过来的数据进行过滤，只有符合条件的才有资格被 subscribe.

`filter `只会让符合条件的元素通过。  
`distinctUntilChanged `会废弃掉重复的事件。  
`take `只获取序列中的前 n 个事件，在满足数量之后会自动 .Completed 。

### Combining 组合
就是把多个 Observable 组合起来使用.

`startWith ` 会在队列开始之前插入一个事件元素。  
`combineLatest ` 如果存在两条事件队列，需要同时监听，那么每当有新的事件发生的时候，combineLatest 会将每个队列的最新的一个元素进行合并。

`zip `   
就是合并两条队列用的，不过它会等到两个队列的元素一一对应地凑齐了之后再合并.   
或者说只有当两个 Observable 都有了新的值时，subscribe 才会被触发.   
或想要创建N个网络请求，等到所有请求都完成了之后映射它们的结果.

`merge ` 把两个队列按照顺序组合在一起。

`switch `
当你的事件序列是一个事件序列的序列 (Observable<Observable<T>>) 的时候，（可以理解成二维序列？），可以使用 switch 将序列的序列平铺成一维，并且在出现新的序列的时候，自动切换到最新的那个序列上。和 merge 相似的是，它也是起到了将多个序列『拍平』成一条序列的作用。  
注意，虽然都是『拍平』，但是和 flatmap 是不同的， flatmap 是将一条序列变成另一条序列，而这变换过程会让维度变高，所以需要『拍平』，而 switch 是将本来二维的序列（序列的序列）拍平成了一维的序列。

### Error Handling
catchError 可以捕获异常事件，并且在后面无缝接上另一段事件序列，丝毫没有异常的痕迹。

retry 顾名思义，就是在出现异常的时候会再去从头订阅事件序列，妄图通过『从头再来』解决异常。


### Utility
subscribe 在前面已经接触过了，有新的事件就会触发。

subscribeNext 也是订阅，但是只订阅 .Next 事件。

subscribeCompleted 是只订阅 .Completed 完成事件。

subscribeError 只订阅 .Error 失败事件。

doOn 可以监听事件，并且在事件发生之前调用。



### Conditional 条件判断
takeUntil 其实就是 take ，它会在终于等到那个事件之后触发 .Completed 事件。

takeWhile 则是可以通过状态语句判断是否继续 take 。


### Aggregate 集合
concat 可以把多个事件序列合并起来。

reduce 同CollectionType 的 reduce，都是指通过对一系列数据的运算最后生成一个结果。


### 其他
`Connect`: 如果一个网络请求只想被触发一次，同时支持多个 subscriber，就可以使用 publish + connect 的组合. 当一个 Observable 使用了 publish() 方法后，正常的 subscribe 就不会触发它了，除非 connect() 方法被调用。[详情1](http://limboy.me/tech/2016/12/11/time-to-learn-rxswift.html) [详情2](http://www.tailec.com/blog/understanding-publish-connect-refcount-share)


`Driver `  
是一个专门针对于UI的特定可观察者类。并不是说对UI进行相应绑定操作不能使用纯粹的Observable，但是，Driver已经帮我们省去了好多的操作，让我们对UI的绑定更加的高效便捷。所以，对UI视图的绑定操作，我们首选“老司机”Driver。



## 坑
deinit 空方法断点不执行, 写个print就执行

dataSource.configureCell 内不要引用self, 会造成循环引用,控制器不能释放



## Swift 第三方库
`RxSwift `: 响应式编程框架  

`RxCocoa `: 该库将UIKit以及Foundation框架中许多成员，如视图(View)、控制事件(Control Event)、键值观察（KVO）、通知（Notification）等等进行与RxSwift接入的扩展，将Rx与iOS API无缝连接。(bindTo 主要用于视图（View）层跟视图模型（ViewModel）层或视图层跟视图层的绑定.)

`RxDataSources `:  使用RxSwift对UITableView和UICollectionView的数据源做了一层包装.

`Alamofire `: Swift版的AFNetworking.

`Moya `: 一款网络请求框架Alamofire的再度封装，它有基于RxSwift的扩展，能与RxSwift无缝对接.

`Argo `: 是一款小巧的JSON解析库，函数柯里化(Currying)库Curry配合着它一起使用，而且，Argo的解析语法非常新颖奇特，用着感觉非常过瘾！

`Curry `: 函数柯里化(Currying)库

`Kingfisher`: 图片处理库

`SwiftDate`: 日期处理库

`Then `: 语法糖快速初始化



[PromiseKit](https://github.com/mxcl/PromiseKit): 一个比较简单的函数化集成第三方库，让 OC 或者 Swift 能够更容易的实现函数化编程.


## 资源链接 
[靛青K](http://blog.dianqk.org/all-categories)  & [参考资源](http://t.swift.gg/d/25-000)

[RxSwift - GitBooks](https://leon_lizi.gitbooks.io/rx-/content)

[南峰子的技术博客](http://southpeak.github.io/2017/01/16/Getting-Started-With-RxSwift-and-RxCocoa)

[limboy 李忠的博客](http://limboy.me)

[RxSwift进阶与实战](http://www.jianshu.com/p/431f645cb805)

[RxSwift 入门](http://blog.callmewhy.com/2015/05/11/functional-reactive-programming-1)  [ RxSwift 入坑手册](http://blog.callmewhy.com/2015/09/21/rxswift-getting-started-0)

[RxSwift 笔记](https://tbxark.site/2015/10/29/2015-10-29-RxSwift-note)   

[ReactiveX序列——RxSwift](http://blog.csdn.net/xwl198937/article/details/50823558)

[田腾飞的博客](http://www.codertian.com)

[Tangent](http://tangent.gift/category)

[nathanwhy](http://nathanwhy.com)

[RxSwift基础](http://www.jvaeyhcd.cc/2016/06/08/RXSwift%E5%9F%BA%E7%A1%80)

[RxSwift 速查手册](http://www.futantan.com/2016/05/05/RxSwiftCheatSheet)

[codercd](http://lichendi.com)

[wolffff](http://wolffff.com)

[开发者头条](https://toutiao.io/tags/RxSwift)

[伯乐在线](http://ios.jobbole.com/tag/rxswift)

[大石头布 的技术blog](http://stonedu.site/categories/RxSwift)

[Moya + SwiftyJSON + RxSwift](http://jkyeo.com/archives)

[刘铎.Me](http://liuduo.me/archives)

[贵永冬](http://www.guiyongdong.com/all-categories)

[美团臧成威的博客](http://williamzang.com/blog/archives): RAC响应式

[操作理论示意图](http://rxmarbles.com): 当数据有变化时，能够立刻知晓，并且通过组合和转换后，可以即时作出响应。

[ReSwift](https://github.com/ReSwift/ReSwift): 单向数据流架构

[移动端数据库新王者：realm](https://realm.io/cn/news/slug-max-alexander-functional-reactive-rxswift)


---
其他文章:  
[SwiftGG翻译组](https://segmentfault.com/u/swiftgg/articles)  -> [在实践中应用 RxSwift](https://segmentfault.com/a/1190000005915774)

[RxSwift给Swift带来了原生Reactive编程的功能](http://www.infoq.com/cn/news/2016/04/rxswift-reactive-swift)

[ReactiveCocoa vs RxSwift 选谁好](http://www.jianshu.com/p/2f83b766a081)

---
Crashlytics: Crash 统计工具
