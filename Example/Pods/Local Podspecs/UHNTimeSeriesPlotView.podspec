#
# Be sure to run `pod lib lint UHNTimeSeriesPlotView.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "UHNTimeSeriesPlotView"
  s.version          = "0.1.0"
  s.summary          = "A dynamic time series plot view"
  s.description      = <<-DESC
                       UHNTimeSeriesPlotView offers the ability to setup a plot and then 
                       add points in real-time that rolls the window left and drops older 
                       points that may not be relevant any more.

                       Current implementation is a fixed window size, but intention is to 
                       add scrolling to view historical data.
                       DESC
  s.homepage         = "https://github.eahlthinnovation.org/JDRF/UHNTimeSeriesPlotView"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Nathaniel Hamming" => "nathaniel.hamming@gmail.com" }
  s.source           = { :git => "https://github.eahlthinnovation.org/JDRF/UHNTimeSeriesPlotView.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/NAteHAm80'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'UHNTimeSeriesPlotView' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
