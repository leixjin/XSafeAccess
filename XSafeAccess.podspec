Pod::Spec.new do |s|
  s.name             = 'XSafeAccess'
  s.version          = '0.0.3'
  s.summary          = 'Protect your array.'

  s.description      = <<-DESC
                       A simple tool to protect your array.
                       DESC

  s.homepage         = 'https://github.com/xiaolei0808/XSafeAccess'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xiaolei.jin' => 'me.xiaolei0808@gmail.com' }
  s.source           = { :git => 'https://github.com/xiaolei0808/XSafeAccess.git', :tag => s.version.to_s }
  s.requires_arc     = false
  s.ios.deployment_target = '7.0'
  s.source_files = 'XSafeAccess/Classes/**/*'
  
end
