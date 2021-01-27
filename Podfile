# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'
use_frameworks!


##################################### pods
def pods 
	# Network
	pod 'Moya/RxSwift'
  
  # Rx extension
  pod 'RxSwiftExt'
  pod 'NSObject+Rx'
  
  
  # JSON Mapping
  pod 'HandyJSON'
  
  # Layout
  pod 'SnapKit'
  
  # Logging日志
  pod 'CocoaLumberjack/Swift'
  
  # MJRefresh
  pod 'MJRefresh'
  
end


################################testing_pods
def testing_pods
  pod 'Quick', '~> 3.0'  # https://github.com/Quick/Quick
  pod 'Nimble', '~> 8.0'  # https://github.com/Quick/Nimble
end


target 'TestProject' do

  pods
  
  target 'TestProjectTests' do
    testing_pods
  end
  
end

