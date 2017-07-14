//
//  Main.h
//  iOSwifter
//
//  Created by ZN on 2017/7/14.
//  Copyright © 2017年 iOSwifter. All rights reserved.
//

#ifndef Main_h
#define Main_h

// APP启动时间
1）main之前: 系统dylib（动态链接库）加载时间 自身App可执行文件加载时间和
2）main之后: 执行didFinishLaunchingWithOptions:结束前的时间


整个调用顺序:
1）dyld 开始将程序二进制文件初始化
2）交由ImageLoader 读取 image，其中包含了我们的类，方法等各种符号（Class、Protocol 、Selector、 IMP）
3）由于runtime 向dylid 绑定了回调，当image加载到内存后，dylid会通知runtime进行处理
4）runtime 接手后调用map_images做解析和处理
5）接下来load_images 中调用call_load_methods方法，遍历所有加载进来的Class，按继承层次依次调用Class的+load和其他Category的+load方法
6）至此 所有的信息都被加载到内存中
7）最后dyld调用真正的main函数
注意：dyld会缓存上一次把信息加载内存的缓存，所以第二次比第一次启动快一点;



// main之前
加载可执行文件（自身app的所有.o文件集合）
加载dyld (dyld是专门用来加载动态链接库的库)
dyld根据可执行文件的依赖，递归加载所有的依赖动态链接库 (动态链接库包括：iOS中用到的所有系统的framework，加载OC runtime方法的libobjec，系统级别的libSystem, 例如libdispatch(GCD)he libsystem_blocks(Block) )
所有动态链接库和App静态库.a和所有类文件编译后的.o文件，最终都由dyld加载到内存


Ps:
动态链接库库是相对于系统来讲
可执行文件是相对于App本身来讲

每个app 都是以镜像为单位进行加载: {
    1）镜像（Mirroring）是冗余的一种类型，一个磁盘上的数据在另一个磁盘上存在一个完全相同的副本即为镜像。
    2）镜像是一种文件存储形式，可以把许多文件做成一个镜像文件。
    3）每个镜像又都有个ImageLoader类来负责加载，一一对应的关系.
}

framework 是动态链接库和相应资源包含在一起的一个文件结构.



动态链接库的加载步骤: {
    1）load dylibs image 读取库镜像文件: {
        1.1）分析所依赖的动态库
        1.2）找到动态库的mach-o 文件(Windows下文件是PE文件，OS X和iOS中可执行文件是Mach-o格式)
        1.3）打开文件
        1.4）验证文件
        1.5）在系统核心注册文件签名
        1.6）对动态库的每一个segment调用mmap()
    }
    2）Rebase image重定位镜像, Bind image组装镜像 {
        由于ASLR（address apace layout randomization）的存在，可执行文件和动态链接库在虚拟内存中的加载地址每次启动都不固定，所以需要两个修复镜像中的资源地址，来指向正确的地址: {
            1）rabase 修复的是指当前镜像内存的资源指针；
            bind   指向的是镜像外部的资源指针
            2）rebase步骤先进行，需要把镜像读入内存，并以page为单位进行加密验证，保证不会被篡改；
            bind 在其后进行，由于要查询表符号表，来指向镜像的资源；
        }
    }
    
    4）Objc setup 设置对象: (静态调整（fix up）, 在修改__DATA segment中内容) {
        1) 注册objc类
        2）把category的定义插入方法列表
        3）保证每个selector唯一
    }
    
    5）initializers 初始化: (动态调整，开始在堆和堆栈写入内容) {
        1）objc 的 + load 函数
        2）C++的构造函数属性函数 形如 attribute((contructor))void DoSomeInitializationWork()
        3）非基本类型的C++静态全局变量的创建（通常是类或结构体）（non-trivial initializer）重大初始化
    }
}


#pragma mark - load and initialize
相同点：{
    在不考虑主动使用的情况下，系统最多会调用一次
    如果父类和子类都被调用，父类的调用一定在子类之前
    都能自动调用父类方法
    都可以手动调用
}

不同点：{
    load在对象没有实例化情况下也会调用
    initialize在对象实例化时才会调用
    load 方法调用在initialize方法之前
}



参考:
http://blog.sunnyxx.com/2014/08/30/objc-pre-main/
http://www.jianshu.com/p/8f14c7a33579

#endif /* Main_h */
