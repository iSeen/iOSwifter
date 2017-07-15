//
//  Main.h
//  iOSwifter
//
//  Created by ZN on 2017/7/14.
//  Copyright © 2017年 iOSwifter. All rights reserved.
//

#ifndef Main_h
#define Main_h

#pragma mark - App启动时间
1）main之前: 系统dylib（动态链接库）加载时间 自身App可执行文件加载时间
2）main之后: 执行didFinishLaunchingWithOptions:结束前的时间

#pragma mark - main之前的事件
main之前: 系统内核做好启动程序的初始准备后, 交由 dyld (Apple 的动态链接器, The Dynamic Link Editor) 主导处理
1)dyld 将程序二进制文件初始化
2)交由 ImageLoader 读取 image, 将 image 加载到内存 {
    1)将动态链接的 image 递归加载
    2)从 image 递归加载所有符号
    Ps: image 非图片, 二进制文件, 包含类、方法等各种符号（Class，Protocol，Selector，IMP，…）
    ImageLoader作用: 将image加载进内存，且每一个文件对应一个ImageLoader实例来负责加载。
}
3)runtime 调用 map_images 做解析和处理 (因 runtime 向 dyld 绑定了回调，当 image 加载到内存后，dyld 会通知 runtime作处理) {
    1>快速查询，类和分类的方法列表中是否含有 load 方法，如果没有，直接返回
    2>递归查询所有的 load 方法，并存储起来
    3>load_images 中调用 call_load_methods 方法, 依次执行已经被存储的 load 方法 {
        依次执行存储的 load 方法，父类 -> 子类 -> 分类
        Ps:
        首先，保证是首次执行， load 方法只会执行一次;
        创建自动释放池，在池内执行方法，优化性能;
        do {} while 循环执行，直到数组为空，且分类方法也执行完毕，不再有新的分类方法;
    }
}
4)至此,可执行文件和动态库所有符号都已经按格式成功加载到内存中，被 runtime 所管理
5)之后,runtime 动态添加的 Class、swizzle 等方法生效
6)最后,dyld调用真正的main函数 (dyld 会清理现场，将调用栈回归)

Ps：dyld会缓存上一次把信息加载内存的缓存，所以第二次比第一次启动快一点;


#pragma mark - load and initialize
// initialize
1) + (void)initialize 消息是在该类接收到其第一个消息之前调用。{
    自动调用 NSObject 的 + (void)load 消息不被视为第一个消息;
    手动调用 NSObject 的 + (void)load 消息，则会引起 + (void)initialize 的调用;
    如果没有向 NSObject 发送第一个消息，+ (void)initialize 则不会被自动调用;
}

2) 在应用程序生命周期中，runtime 只会向每个类发送一次 + (void)initialize 消息. {
    如果该类是子类，且该子类中没有实现 + (void)initialize 消息，或者子类显示调用父类实现 [super initialize], 那么则会调用其父类的实现. 也就是说，父类的 + (void)initialize 可能会被调用多次。
}

3) 如果类包含分类，且分类重写了initialize方法，那么则会调用分类的 initialize 实现，而原类的该方法实现不会被调用，这个机制同 NSObject 的其他方法(除 + (void)load 方法) 一样，即如果原类同该类的分类包含有相同的方法实现，那么原类的该方法被隐藏而无法被调用。

4) 父类的 initialize 方法先于子类的 initialize 方法调用。

// load
1) + (void)load 会在类或者类的分类添加到 Objective-c runtime 时调用，该调用发生在 application:willFinishLaunchingWithOptions: 调用之前调用。
2) 父类的 +load 方法先于子类的 +load 方法调用，类本身的 +load 方法调用先于分类的 +load 方法调用。



参考:
http://blog.sunnyxx.com/2014/08/30/objc-pre-main/
http://www.jianshu.com/p/8f14c7a33579

#endif /* Main_h */
