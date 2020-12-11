require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-crowdin"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  crowdin/react-native-sdk
                   DESC
  s.homepage     = "https://github.com/crowdin/react-native-sdk"
  # brief license entry:
  s.license      = "MIT"
  # optional - use expanded license entry instead:
  # s.license    = { :type => "MIT", :file => "LICENSE" }
  s.authors      = { "Crowdin" => "support@crowdin.com" }
  s.platforms    = { :ios => "9.0" }
  s.source       = { :git => "https://github.com/crowdin/react-native-sdk.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,swift}"
  s.requires_arc = true

  s.dependency "React"
  s.dependency "CrowdinSDK", '~> 1.1.7'
  s.dependency "CrowdinSDK/Settings", '~> 1.1.7'
end

