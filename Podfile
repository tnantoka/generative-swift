use_frameworks!

target 'GenerativeSwift' do
  pod 'C4'
  pod 'RFAboutView-Swift'
end

post_install do |installer|
  require 'fileutils'
  FileUtils.cp_r('Pods/Target Support Files/Pods-GenerativeSwift/Pods-GenerativeSwift-acknowledgements.plist', 'GenerativeSwift/Acknowledgements.plist', remove_destination: true)
end

