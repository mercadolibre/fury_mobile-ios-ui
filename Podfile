source 'https://github.com/CocoaPods/Specs.git'

workspace 'MLUI'
project 'MLUI.xcodeproj'

use_frameworks!

platform :ios, '10.0'

target 'MLUI' do
    pod 'MLUI', :path => "./"
    pod 'FXBlurView', '~> 1.6'

    target 'MLUIUnitTests' do
	inherit! :search_paths
  	pod 'OCMock', '3.4.1'
    end
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
		preprocessor_macros = config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)']
		preprocessor_macros << 'MLUI_OVERRIDE_FONT=1'
	end
    end
end
