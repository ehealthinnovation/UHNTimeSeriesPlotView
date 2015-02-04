Pod::Spec.new do |s|
  s.name         = "UHNDebug"
  s.version      = "0.1.0"
  s.summary      = "Objective-C Debugging macro"

  s.description  = <<-DESC
                   A simple debugging macro to be noisy in DEBUG builds, and silent otherwise.
                   DESC

  s.homepage     = "http://github.ehealthinnovation.org/PHIT/UHNDebug"

  s.license      = { :type => 'Custom', :text => 'Copyright 2014 University Health Network. All rights reserved.' }

  s.author       = { "Jay Moore" => "jmoore@ehealthinnovation.org" }

  s.platform     = :ios, '6.0'

  s.source       = { :git => "http://github.ehealthinnovation.org/PHIT/UHNDebug.git", :tag => "0.1.0" }

  s.source_files  = 'UHNDebug.h'
  s.public_header_files = 'UHNDebug.h'

end
