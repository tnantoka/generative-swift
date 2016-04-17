use_frameworks!

pod 'C4', :head
pod 'RFAboutView-Swift', :head

post_install do |installer|
  require 'fileutils'
  FileUtils.cp_r('Pods/Target Support Files/Pods/Pods-acknowledgements.plist', 'GenerativeSwift/Acknowledgements.plist', remove_destination: true)
end

