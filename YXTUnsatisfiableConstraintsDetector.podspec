#
# Be sure to run `pod lib lint YXTUnsatisfiableConstraintsDetector.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "YXTUnsatisfiableConstraintsDetector"
  s.version          = "0.2.0"
  s.summary          = "A utility for detecting unsatisfiable constraint errors and calling back to allow automated runtime handling."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
  YXTUnsatisfiableConstraintsDetector is a debugging tool that catches unsatisfiable constraint errors as they appear at the console and provides call backs either directly to blocks or via NSNotificationCenter. This allows such errors to be handled at runtime.

This tool is intended for debugging only, and has not been designed for production-level performance.
                       DESC

  s.homepage         = "https://github.com/yext/YXTUnsatisfiableConstraintsDetector"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Tom Elliott" => "telliott@yext.com" }
  s.source           = { :git => "https://github.com/yext/YXTUnsatisfiableConstraintsDetector.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'YXTUnsatisfiableConstraintsDetector' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
