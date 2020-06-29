#
# Be sure to run `pod lib lint BeiJingDailyInfomant.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BeiJingDailyInfomant'
  s.version          = '0.1.0'
  s.summary          = 'A short description of BeiJingDailyInfomant.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/silverBullet/BeiJingDailyInfomant'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'silverBullet' => 'ios_yangyujing@163.com' }
  s.source           = { :git => 'https://github.com/silverBullet/BeiJingDailyInfomant.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = '**/*.{h,m}'
  
  s.resource_bundles = {
    'BeiJingDailyInfomant' => ['BeiJingDailyInfomant/Assets/*.png']
  }
  s.info_plist = {
    'NSCameraUsageDescription' => '要用您的相机'
  }
  #s.prefix_header_contents = '#import YJUsefulUIKit.h', '#import MJExtension.h'
  s.prefix_header_file = false
  s.prefix_header_file = 'PrefixHeader.pch'
  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'MobileCoreServices', 'Photos'
  s.dependency 'YJUsefulUIKit'
  s.dependency 'MJExtension'
  s.dependency 'Masonry'
  s.dependency 'MGJRouter'
  s.dependency 'TZImagePickerController', '~> 3.3.2'
end
