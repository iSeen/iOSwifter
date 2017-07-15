# iOSwift

## 闭包
	func pingfang(a: Float) -> Float {
	   return a * a
	}
	func lifang(a: Float) -> Float {
	   return a * a * a
	}
	func tongyongOne(a: Float, b: Float, f: ((Float) -> Float)) -> (Float) {
	   return (f(a) + f(b)) / 2
	}
	
	let x = tongyongOne(a: 3, b: 4, f: pingfang)
	print(x)
	
	//(x: Float) -> Float 是闭包的类型（接收一个float参数，返回一个float值）， return x * x 为实现，关键字in为代码头，实现跟在in后面
	let y = tongyongOne(a: 3, b: 4, f: {(x: Float) -> Float in return x * x})
	print(y)
	
	//忽略类型声明
	let z = tongyongOne(a: 3, b: 4, f: {x in return x * x})
	print(z)
	
	//忽略return语句
	let m = tongyongOne(a: 3, b: 4, f: {x in x * x})
	print(m)
	
	//忽略指定参数名，使用默认参数名$0（如果函数接收多个参数，使用$K作为第K-1个参数，如$0，$1，$2......）
	let n = tongyongOne(a: 3, b: 4, f: {$0 * $0})
	print(n)


## 高阶函数
### 数组操作高阶函数 map，filter和reduce
#### Map 用于将每个数组元素通过某个方法进行转换
map被声明成Array类的命名方法：
	
	func map(transform: (T) -> U) -> U[] 
	
以一个命名函数transform作为参数，transform负责把元素类型T转成类型U并返回一个类型U的数组
	
	stringsArray = moneyArray.map({"\($0)?"})
	stringsArray = moneyArray.map({money in "\(money)?"})  带命名参数
	
#### Filter 用于选择数组元素中满足某种条件的元素
filter在Array类中的定义为：

	filter(includeElement: (T) -> Bool) -> T[]
以返回true或false的函数includeElement作为参数，对原数组元素调用includeElement时，只有返回true的元素会通过筛选.

对数组筛选，我们只需使用

	filteredArray = moneyArray.filter({$0 > 30})
{$0 > 30}为筛选闭包，我们忽略了参数名而使用默认参数$0，返回类型隐式推断为Bool

#### Reduce 把数组元素组合计算为一个值
reduct在Array类中的定义为

	reduce(initial: U, combine: (U, T) -> U) -> U
接收两个参数，一个为类型U的初始值，另一个为把类型为U的元素和类型为T的元素组合成一个类型为U的值的函数。最终结果整个数组就变成了一个类型为U的值。

数组元素计算和:

	sum = moneyArray.reduce(0,{$0 + $1})
	sum = moneyArray.reduce(0,+)  简化
combine函数的两参数类型不同，$0为计算结果类型，$1为数组元素类型



#### 🐲 命名规范: 驼峰命名
1.采用大驼峰
对 类、结构体、枚举、协议 等类型命名，如 SplitViewController;  
固定常量/宏，如 MaxStudentNumber 或 APP_ID;  
文件名，如 BlockOperation.swift;  
扩展文件，文件名命名是“原始类型名+扩展名”，如 NSOperation+Operations.swift;

2.小驼峰  
一般常亮;
变量和属性，如 studentNumber;  
函数和方法，如 balanceAccount、isButtonPressed等;


#### 🐲 代码地标注释(可在Xcode的 Jump Bar中点击跳转)
MARK: - 用于方法或函数的注释;
TODO: - 表示这里代码有没有完成，还要处理;
FIXME: - 表示这里修改了代码;

#### 🐲 Debug和release管理print()
方法一: 直接用系统的 debugPrint()
方法二: 自定义
创建swift文件类型的文件(类似OC的.pch文件), 然后加入以下代码, 即可在其他地方调用;

func ZNLog(item: Any...) {
#if DEBUG
print("文件:"+"\(NSURL(fileURLWithPath:#file).lastPathComponent!)")
//print("位置:"+"\(#line)") 没用
print("内容:"+"\(item.last!)")
#endif
}

自定义好处:  
1.容易区分;  
2.可以扩充一些其他功能，可打印具体细节;(系统自带打印print，只对当前括号中的对应内容进行打印)  
3.可以在debug环境下停止打印.


#### 🐲 关键词

##### @objc

##### @escaping
当闭包作为一个参数传递到函数,且需异步回调使用时, 需在形参关键字前加此关键词; 一般用于网络成功和失败回调.

##### convenience  

#####  guard
-> 提高代码的可读性，但代码执行会有非常明确的顺序性
-> 与 if 类似, 二者区别:
1.guard 必须强制有 else 语句
2.条件成立，才会执行 guard 之后的代码; 
条件不成立, 执行 else 代码 (else 只能执行转换语句，如 return, break, continue 或 throws 或返回一个函数或方法)

##### lazy
适用情景:  
(1) 属性开始时还不确定是什么或者是否会被用到.  
(2) 属性需要复杂的计算:会消耗大量的CPU.  
(3) 属性只需要初始化一次时. 
需注意:
1. 被lazy修饰的属性要用var来声明;  
因为该属性在类或对象的实例初始化完成前还不能拥有一个值,而且访问该属性是一个mutating操作,所以包含该属性的struct或class也应该是可被修改的.而用let修饰的全局常量或者类属性(type property)却默认是lazy的(也是线程安全的). 
2.即在多线程操作中, 被lazy修饰的属性可能被多个线程访问,则只初始化一次就不能保证了.
替代方案:像< Lazy Properties in Structs >那样在属性创建前根据判断是否已存在而作不同的操作.
3.其他用法:
在对集合类型(如Array)使用高阶函数(如map)时,所有的结果会在第一次访问前就计算出来,即使我们只访问其中的一个元素:

let array = Array(0..<100)

let result = array.lazy.map { (i: Int) -> Int in  //延迟加载, 不访问不打印所有元素

//let result = array.map { (i: Int) -> Int in  //访问打印所有元素
print("测试是否访问所有元素访: \(i)")
return i*2
}
print("\n 只想访问数组最后一个元素: \(result[99])")

在集合类中有个名为 lazy 的属性，它包含的内容与所在的集合类对象一样，并且可以对 “map”,”filter” 等操作延迟实现, 所以这样使用lazy可以大大优化性能.


##### mutating  
修饰方法是为能在该方法中修改 struct 或是 enum 的变量;   
(protocol方法声明, struct, enum前都要加, class前不需加)

##### required  
1.只能用于修饰类初始化方法;  
2.当子类含有异于父类的初始化方法时（初始化方法参数类型和数量异于父类），子类必须要实现父类的required初始化方法，并且也要使用required修饰符而不是override;  
3.当子类没有初始化方法时，可以不用实现父类的required初始化方法。




##### 🐲 数据类型
Swift与C/C++混合编程之数据类型映射, OC可直接使用C数据类型, Swift不能直接使用C, 需要转化,Swift中使用CInt表示;

let intSwift = 10   //intSwift所存储10是Int类型
print(CInt(intSwift))  //CInt(intSwift)是实例化CInt类型，它实现了将Int类型转化为C语言int类型;


##### 🐲 控制流
do-while 已废弃，变为: repeat-while  
ps:为增强代码的可读性, 统一将do开头的作为异常处理,如do-catch;


##### 🐲 extension
//  类型扩展 (引用类型 / 值类型 / 计算属性 / 静态属性 / 方法<动态和静态>)

import UIKit

// 引用类型扩展
class ZNExtension {

var name: String
var age: Int

func description() -> String {
return "name: \(self.name), age: \(self.age)"
}

init(name: String, age: Int) {
self.name = name
self.age = age
}
}

extension ZNExtension {
convenience init(name: String) {
self.init(name: name, age: 80)
}
}

// 值类型扩展
struct ZNStructExtension {

var width: Double
var height: Double

init(width: Double, height: Double) {
self.width = width
self.height = height
}
}

extension ZNStructExtension {
init(lenth: Double) {
self.init(width: lenth, height: lenth)
}
}

// 计算属性扩展
extension Int {

var errorMessage: String {

var errorStr = ""

switch self {
case 1:
errorStr = "1"
default:
errorStr = "不是1"
}
return errorStr
}
}
调用:
//Int类型计算属性扩展
let errorStr1 = 7.errorMessage
let errorStr2 = (-7).errorMessage //负号要加括号	

// 静态属性扩展
struct Account {

var amount: Double = 0.0  //账户金额
var owner: String = ""    //账户名
}

extension Account {

static var interestRate: Double { //利率
return 0.086
}
}


// 方法扩展
extension Double { //定义Double类型的扩展

static var interestRate: Double = 0.0668 //利率

func interestBy1() -> Double {
return self * Double.interestRate
}
// 调用: let interest1 = (10_000.00).interestBy1()


mutating func interestBy2() {
self = self * Double.interestRate
}
// 调用实例方法: var interest2 = 10_000.00
//      interest2.interestBy2()


static func interestBy3(amount : Double) -> Double {
return interestRate * amount
}
// 调用静态方法: var interest3 = Double.interestBy3(10_000.00)

}




##### 🐲 异常处理
do 用于异常处理, Swift2.0 新增异常处理关键字: catch、try、throw、 rethrows、throws;  

处理异常方式:  
do...catch   
会抛出异常的代码放在关键字 do 包含的代码块里;  
使用 catch 关键字匹配要捕捉的各种异常;

可能会抛出异常的方法声明: 参数后加 throws 关键字;  
产生并抛出错误方式: 在函数或方法中通过 throw 语句，人为地抛出错误;


调用(会抛出异常的)方法: 方法前使用 try 关键字;  

let a = try? testErr.action(number: 3)

try? 和 try! 区别:  
try?: 会将错误转换为可选值，当调用try?＋函数或方法语句时候，如果函数或方法抛出错误，程序不会发崩溃，而返回一个nil，如果没有抛出错误则返回可选值。 使用了 try? 语句没有必要使用do-catch语句将其包裹起来.  
try!: 可以打破错误传播链条。错误抛出后传播给它的调用者，这样就形成了一个传播链条，但有的时候确实不想让错误传播下去，可以使用 try! 语句。 使用 try! 打破错误传播链条时，应该确保程序不会发生错误;  
参考: http://blog.csdn.net/tonny_guan/article/details/50455555

import UIKit

// 使用 枚举 创建异常类型
enum ErrType: Error {
case ErrorNegative
case ErrorZero
}

class ZNErrorHandle {

func action(number: Int) throws {

defer {

/*
defer: 无论代码执行正常与否，只要离开当前作用域，就一定会执行的代码, 用此关键字指定

调用方式:  try! method ...
try! 形式: 由于defer代码块中，不允许我们包含任何会跳出当前代码块的语句，例如：break ／ return / 抛出异常等。因此，我们使用 try! 告诉Swift我们确定这个调用不会发生异常（如果你对Swift说谎，是会引发运行时异常的 ^.^）。
使用"try!"标记的函数调用，可以不放在do代码块里。
*/
}

do {
// try method1 ...
// try method2 ...

guard number > 0 else {

if number < 0 {
throw ErrType.ErrorNegative
}
throw ErrType.ErrorZero
}
print("数据大于0, 正常")

} catch ErrType.ErrorNegative {
print("负数")
} catch ErrType.ErrorZero {
print("零")
}
}
}


##### print()
let str: String? = "zan"
print("str: \(str), type: \(type(of: str))") //打印对象类型


#### 🐲 技术链接:
[textField和textView各自限定输入字符数的方法](http://www.jianshu.com/p/5b6c9d83852a)

[Core Foundation框架之内存托管对象与非托管对象](http://blog.csdn.net/tonny_guan/article/details/50546668)

[API文档管理](http://api.daza.io/docs)

