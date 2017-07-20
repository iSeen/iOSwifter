# Podfile

platform :ios, '8.0'
inhibit_all_warnings!  
use_frameworks!


# FRP
def frp_pods
    pod 'RxSwift',    '~> 3.0'
    pod 'RxCocoa',    '~> 3.0'
    pod 'RxDataSources', '~> 1.0'
    pod 'ReactiveCocoa', '~> 2.5'
end


# 网络数据
def netWorkData_pods
    pod 'Alamofire', '~> 4.4'
    pod 'Moya'
    pod 'AlamofireImage', '~> 3.1'

    pod 'SwiftyJSON'
    
    pod 'ReSwift'

    pod 'WCDB'
    pod 'FMDB'
#    pod 'Realm'
#    pod 'SQLite.swift'
end


# UI
def ui_pods
#    pod 'RAMAnimatedTabBarController'
#    pod 'SDCycleScrollView','~> 1.66'

    pod 'Texture'
    pod 'IQKeyboardManagerSwift'
    
    pod 'Masonry'
    pod 'SnapKit', '~> 3.0.2'
end


# other
def other_pods
    pod 'R.swift'
    pod 'JLRoutes', '~> 2.0.5'
    pod 'MLeaksFinder'
end



target 'iOSwifter' do
  frp_pods
  netWorkData_pods
  ui_pods
  other_pods
end



#post_install do |installer|
#    installer.pods_project.targets.each do |target|
#        target.build_configurations.each do |config|
#            config.build_settings['SWIFT_VERSION'] = '3.0'
#            config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.12'
#        end
#    end
#end



