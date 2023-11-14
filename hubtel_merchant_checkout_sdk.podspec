#
# Be sure to run `pod lib lint hubtel_merchant_checkout_sdk.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'hubtel_merchant_checkout_sdk'
  s.version          = '0.2.0'
  s.summary          = 'The Hubtel Checkout Library is a convenient and easy-to-use library that simplifies the process of implementing a checkout flow in your iOS application.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/hubtel/hubtel_checkout_sdk_ios_pods'
   s.screenshots     = 'https://firebasestorage.googleapis.com/v0/b/newagent-b6906.appspot.com/o/hubtel-mobile-checkout-ios-sdk-image.png?alt=media&token=376d90ab-c416-42a0-8b99-69028378ff72'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '85908865' => 'markamoah97@gmail.com' }
  s.source           = { :git => 'https://github.com/hubtel/hubtel_checkout_sdk_ios_pods.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'
  s.swift_version = '5.0'
  s.source_files = ['TableCells/*.swift','Resources/*', 'Networking/*','Assets.xcassets', 'GeneralPages/**/*', 'CustomViews/*', 'Analytics/*', 'General/*', 'CustomViews/otpLibrary/*']
 
  s.resource_bundles = {
    'hubtel_merchant_checkout_sdk' => ['Assets.xcassets', 'hubtel_merchant_checkout_sdk/Resources/*.ttf']
  }
  
  # s.resource_bundles = {
  #   'hubtel_merchant_checkout_sdk' => ['hubtel_merchant_checkout_sdk/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
