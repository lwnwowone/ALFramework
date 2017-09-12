#
# Be sure to run `pod lib lint ALFramework.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ALFramework'
  s.version          = '1.0.0'
  s.summary          = 'Personal library for developing.'
  s.description      = 'Personal library for developing.'
  s.homepage         = 'https://github.com/lwnwowone/ALFramework'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'AlancLiu' => 'lwnwowone@gmail.com' }
  s.source           = { :git => 'https://github.com/lwnwowone/ALFramework.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'ALFramework/Classes/**/*'
  s.dependency 'WCDB'
end
