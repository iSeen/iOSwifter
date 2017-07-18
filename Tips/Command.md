### 显示隐藏文件
	defaults write com.apple.finder AppleShowAllFiles Yes && killall Finder

### 不显示隐藏文件
	defaults write com.apple.finder AppleShowAllFiles No && killall Finder
	

### 检测苹果ATS [iOS9适配ATS](http://www.cocoachina.com/ios/20151021/13722.html)
	nscurl --ats-diagnostics --verbose https://域名地址
	如果HTTPS服务器能通过ATS特性，则上面所有测试案例都是PASS；
