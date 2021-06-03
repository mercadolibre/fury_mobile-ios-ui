source 'git@github.com:mercadolibre/mobile-ios_specs.git'
source 'https://cdn.cocoapods.org'

workspace 'MLUI'
project 'MLUI.xcodeproj'

use_frameworks!

platform :ios, '10.0'

install! 'cocoapods',
  :generate_multiple_pod_projects => true,
  :incremental_installation => true

target 'MLUI-Example' do
    pod 'MLUI', :path => "./"
    pod 'FXBlurView', '~> 1.6'

    target 'MLUIUnitTests' do
	inherit! :search_paths
  	pod 'OCMock', '3.4.1'
    end
end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.build_configurations.each do |config|
            preprocessor_macros = config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)']
            preprocessor_macros << 'MLUI_OVERRIDE_FONT=1'
        end
    end
end
