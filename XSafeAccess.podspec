Pod::Spec.new do |s|
  s.name             = 'XSafeAccess'
  s.version          = '0.0.1'
  s.summary          = 'Protect your array.'

  s.description      = <<-DESC
                       A simple tool to protect your array.
                       DESC

  s.homepage         = 'https://github.com/xiaolei0808/XSafeAccess'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xiaolei.jin' => 'me.xiaolei0808@gmail.com' }
  s.source           = { :git => 'https://github.com/xiaolei0808/XSafeAccess.git', :tag => s.version.to_s }

#s.social_media_url = 'https://twitter.com/xiaolei0808'

  s.ios.deployment_target = '7.0'

  s.source_files = 'XSafeAccess/Classes/**/*'
end
