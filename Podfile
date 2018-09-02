# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ANIDESU-POI' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ANIDESU-POI
  pod 'Alamofire'
  pod 'Kingfisher'
  pod 'RxCocoa'
  pod 'RxSwift'
  pod 'Hero'
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'Firebase/Database'
  pod 'Firebase/Storage'
  pod 'Firebase/Firestore'
  pod 'MBProgressHUD'
  pod 'Tabman'
  pod 'WCLShineButton'
  pod 'IHKeyboardAvoiding'
  pod 'Eureka'
  pod 'Cosmos', '~> 16.0'
  pod 'UITextView+Placeholder'
  
  post_install do |installer|
      installer.pods_project.build_configurations.each do |config|
          config.build_settings.delete('CODE_SIGNING_ALLOWED')
          config.build_settings.delete('CODE_SIGNING_REQUIRED')
      end
  end

  target 'ANIDESU-POITests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ANIDESU-POIUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
