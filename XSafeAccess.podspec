#
# Be sure to run `pod lib lint XSafeAccess.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XSafeAccess'
  s.version          = '0.0.1'
  s.summary          = 'Protect your array.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                       A simple tool to protect your array.
                       DESC

  s.homepage         = 'https://github.com/xiaolei0808/XSafeAccess'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xiaolei.jin' => 'me.xiaolei0808@gmail.com' }
  s.source           = { :git => 'https://github.com/xiaolei0808/XSafeAccess.git', :tag => s.version.to_s }

  s.social_media_url = 'https://twitter.com/xiaolei0808'

  s.ios.deployment_target = '7.0'

  s.source_files = 'XSafeAccess/Classes/**/*'
end
