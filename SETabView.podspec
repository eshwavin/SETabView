Pod::Spec.new do |s|
  s.name             = 'SETabView'
  s.version          = '0.3.0'
  s.summary          = 'SETabView is a custom TabBar with really cool animations'

  s.description      = <<-DESC
'SETabView is a TabBar with simple yet beautiful animations that makes your apps look cool!'
                       DESC

  s.homepage         = 'https://github.com/eshwavin/SETabView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'eshwavin' => 'eshwavin@gmail.com' }
  s.source           = { :git => 'https://github.com/eshwavin/SETabView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://www.instagram.com/eshwavin/'

  s.ios.deployment_target = '11.0'

  s.source_files = 'Source/**/*.swift'
  
  s.swift_version = '5.0'
  
  # s.resource_bundles = {
  #   'SETabView' => ['SETabView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
