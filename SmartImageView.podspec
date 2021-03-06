#
# Be sure to run `pod lib lint SmartImageView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SmartImageView'
  s.version          = '0.1.3'
  s.summary          = 'UIImageView that detects faces and adds custom views over them. Uses Vision API from Apple.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Simple UIImageView component'

  s.homepage         = 'https://github.com/manuelbulos/SmartImageView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'manuelbulos' => 'manuelbulos@gmail.com' }
  s.source           = { :git => 'https://github.com/manuelbulos/SmartImageView.git', :tag => s.version.to_s }
  s.social_media_url = 'https://www.manuelbulos.com'

  s.ios.deployment_target = '11.0'
  s.swift_version = '4.2'

  s.source_files = 'SmartImageView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SmartImageView' => ['SmartImageView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
