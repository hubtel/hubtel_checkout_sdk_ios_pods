#
# Be sure to run `pod lib lint hubtel_merchant_checkout_sdk.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'hubtel_merchant_checkout_sdk'
  s.version          = '0.1.1'
  s.summary          = 'A short description of hubtel_merchant_checkout_sdk.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/hubtel/hubtel_checkout_sdk_ios_pods'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '85908865' => 'markamoah97@gmail.com' }
  s.source           = { :git => 'https://github.com/hubtel/hubtel_checkout_sdk_ios_pods.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'

  s.source_files = ['TableCells/*.swift','Resources/*', 'Assets/*', 'Networking/*', 'GeneralPages/**/*', 'CustomViews/*', 'Analytics/*', 'General/*', 'CustomViews/otpLibrary/*']
#  s.resource_bundles = {
#    'hubtel_merchant_checkout_sdk' => ['hubtel_merchant_checkout_sdk/Assets/*.png', 'hubtel_merchant_checkout_sdk/Resources/*.ttf']
#  }
  
  # s.resource_bundles = {
  #   'hubtel_merchant_checkout_sdk' => ['hubtel_merchant_checkout_sdk/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
