#
#  Be sure to run `pod spec lint JKRefresh.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

s.name         = "JKRefresh"
s.version      = "0.0.1"
s.summary      = "JKRefresh,easy for refresh"
s.description  = <<-DESC
JKRefresh,for oc refresh,自定义刷新。
DESC
s.homepage     = "https://github.com/Jacky-LinPeng/JKRefresh"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author             = { "linpeng" => "540933120@qq.com" }
s.platform     = :ios, '7.0'
s.source       = { :git => "https://github.com/Jacky-LinPeng/JKRefresh.git", :tag => s.version.to_s }
s.source_files  = "JKRefresh/**/*.{h,m}"
end
