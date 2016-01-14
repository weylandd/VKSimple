Pod::Spec.new do |s|
  s.name             = "VKSimple"
  s.version          = "0.1.1"
  s.summary          = "VKSimple"

  s.homepage         = "https://github.com/weylandd/VKSimple"
  s.license          = 'MIT'
  s.author           = { "Alex Kopachev" => "jioruh2011@ya.ru" }
  s.source           = { :git => "https://github.com/weylandd/VKSimple.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'VKSimple' => ['Pod/Assets/*.png']
  }

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.dependency 'AFNetworking', '~> 2.3'
end
