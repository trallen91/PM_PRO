# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'PM_PRO_J' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  source 'https://github.com/ResearchSuite/Specs.git'
  source 'https://github.com/CuriosityHealth/Specs.git'
  source 'https://github.com/CocoaPods/Specs.git’

  # Pods for PM_PRO_J
  pod "ResearchSuiteExtensions", '~> 0.20'
  pod "ResearchSuiteResultsProcessor", '~> 0.9’
  pod 'LS2SDK', '~> 0.11'
  
  pod "sdlrkx"
  pod "ResearchKit", '~> 1.5’
  pod "ResearchSuiteTaskBuilder", '~> 0.13'

  pod "ResearchSuiteAppFramework", :git => 'https://github.com/ResearchSuite/ResearchSuiteAppFramework-iOS', :branch => 'reduction'

  target 'PM_PRO_JTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'PM_PRO_JUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
