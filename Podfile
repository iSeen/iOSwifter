# Podfile

platform :ios, '8.0'
inhibit_all_warnings!  
use_frameworks!


# 网络
def network_pods
  pod 'Alamofire', '~> 4.4'
  pod 'SwiftyJSON'
  pod 'Moya'
end


# 存储
def storage_pods
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
end


# Resource
def resource_Pods
  pod 'R.swift'
end


# 路由跳转
def route_Pods
    pod 'JLRoutes', '~> 2.0.5'
end


target 'iOSwifter' do
  network_pods
  storage_pods
  ui_pods
  autoLayout_pods 
  resource_Pods
  route_Pods
end


