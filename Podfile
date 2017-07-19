# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'PrideMap' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for PrideMap
  pod 'RazzleDazzle'
  pod 'Cheers', :git => 'https://github.com/hyperoslo/Cheers.git'
  pod 'IBAnimatable'
  
  post_install do | installer |
      require 'fileutils'
      FileUtils.cp_r('Pods/Target Support Files/Pods-PrideMap/Pods-PrideMap-acknowledgements.plist', 'PrideMap/Settings.bundle/Acknowledgements.plist', :remove_destination => true)
  end
end
