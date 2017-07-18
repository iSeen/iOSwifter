# python

## Mac搭建python环境
### 一.安装python
Mac系统自带python执行环境，只能运行python，不够开发，需要重新安装python.  

两种安装方法:  
1.homebrew安装   
`brew install python` 
简单,出错可加sudo试试,此安装的python可能不是最新版.

2.[官网下载安装](https://www.python.org/download)  
安装最新版python,傻瓜安装一路OK,缺点是以后升级,卸载都得自己维护.

两个方法安装的python位置是不一样的,大家可以用:  
`which python` 查看安装位置  
`python` 验证安装是否成功

### 二.安装pip
#### 先获取pip安装脚本  
若安装wget执行: 
`wget https://bootstrap.pypa.io/get-pip.py`   
若没安装wget, 可在本项目中下载get-pip.py文件.

#### 安装pip
cd到get-pip.py文件目录下执行
`sudo python get-pip.py`  
执行`pip` 检测安装是否成功, 如果不行重启终端后尝试.

#### 修改pip源
国内因x网使用pip安装一些模块会特别慢甚至无法下载, 需要修改pip的源到国内的一些镜像地址.

	cd ~   		     进入home目录
	mkdir .pip   	 创建.pip目录
	touch pip.conf   创建pip.conf文件
	
	打开pip.conf文件添加如下内容:
	[global]
	index-url = http://pypi.v2ex.com/simple   可把index-url的值设为自己实际源地址

	pip源修改成功,以后使用pip安装模块时都会从这个源去下载安装.
	
### 三.其他模块安装
#### Pillow/PIL

PIL用于python处理图片, 因PIL长期没更新, 所以有了Pillow这个模块, 依赖于PIL, 新版的pip安装后会自带Pillow, 但是好像没有zlib模块, 所以会报错:
	
	File "/Library/Python/2.7/site-packages/PIL/Image.py", line 1105, in paste
	    im.load()
	
	  File "/Library/Python/2.7/site-packages/PIL/ImageFile.py", line 190, in load
	
	    d = Image._getdecoder(self.mode, d, a, self.decoderconfig)
	
	  File "/Library/Python/2.7/site-packages/PIL/Image.py", line 389, in _getdecoder
	
	    raise IOError("decoder %s not available" % decoder_name)
	
	IOError: decoder zip not available

因此需要手动重新安装:
`sudo pip install -U Pillow`

