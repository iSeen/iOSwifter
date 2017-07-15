# Podfile

platform :ios, '8.0'
inhibit_all_warnings!  
use_frameworks!


# 网络
def network_pods
  pod 'AFNetworking', '~> 3.0'
  pod 'Alamofire', '~> 4.4'
  pod 'AlamofireImage', '~> 3.1'
  pod 'SDWebImage'
  pod 'SwiftyJSON'
  pod 'Moya'
end


# 存储
def storage_pods
  pod 'FMDB'
  pod 'Realm'
  pod 'SQLite.swift'
end


# UI
def ui_pods
  pod "Texture"
  #pod 'RAMAnimatedTabBarController'
end


# autoLayout
def autoLayout_pods
  pod 'Masonry'
  pod 'SnapKit', '~> 3.0.2'
end


# Resource
def resource_Pods
  pod 'R.swift'
end


# FRP
def frp_Pods
  pod 'RxSwift',    '3.0.0-beta.2'
  pod 'RxCocoa',    '3.0.0-beta.2'
  pod 'ReactiveCocoa', '~> 5.0.0'
end


# 路由跳转
def route_Pods
    pod 'JLRoutes', '~> 2.0.5'
end


# 键盘
def keyboard_Pods
    pod 'IQKeyboardManagerSwift'
end


# View
def view_Pods
    #pod 'SDCycleScrollView','~> 1.66'
end



target 'iOSwifter' do
  network_pods
  storage_pods
  ui_pods
  autoLayout_pods 
  resource_Pods
  frp_Pods
  route_Pods
  keyboard_Pods
  view_Pods
end



post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
            config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.12'
        end
    end
end



