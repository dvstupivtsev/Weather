platform :ios, '12.0'

use_frameworks!
inhibit_all_warnings!

target 'Weather' do
    pod 'Sourcery'
    pod 'PromisesSwift'

    target 'WeatherTests' do
        inherit! :search_paths
    end
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
      puts target.name
    end
end
