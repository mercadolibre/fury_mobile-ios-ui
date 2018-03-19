source 'https://github.com/CocoaPods/Specs.git'

workspace 'MLUI'
project 'MLUI.xcodeproj'

use_frameworks!

platform :ios, '7.0'

target 'MLUI' do
    pod 'MLUI', :path => "./"
    pod 'FXBlurView', '~> 1.6'

    target 'MLUIUnitTests' do
	inherit! :search_paths
  	pod 'OCMock'
    end
end
