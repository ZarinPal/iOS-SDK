Pod::Spec.new do |s|
s.name         = 'ZarinPal'
s.module_name  = 'ZarinPal'
s.version      = '1.0.3'
s.summary      = 'ZarinPal In App Billing - Purchase SDK | MPG'
s.description  = <<-DESC
ZarinPal Purchase SDK Provides payment methods on your iOS Application.
ZarinPal co
DESC

s.requires_arc = true

s.homepage     = 'https://github.com/ZarinPal/iOS-SDK'
s.license =    { :type => 'proprietary', :text => <<-LICENSE
Copyright 2021 - present ZarinPal. All rights reserved.
LICENSE
}
s.author       = { 'Farshid Roohi' => 'farshid.roohi.a@gmail.com' }
s.source = { :http => 'https://github.com/ZarinPal/iOS-SDK/releases/download/1.0.3/ZarinPalFramework.zip' }

s.platform = :ios
s.ios.deployment_target = '11.0'

s.frameworks = 'SocketIO', 'Starscream'
s.vendored_frameworks  = 'ZarinPal.framework'
end
