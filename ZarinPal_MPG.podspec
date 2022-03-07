Pod::Spec.new do |s|
s.name         = 'ZarinPal_MPG'
s.module_name  = 'ZarinPal_MPG'
s.version      = '1.1.11'
s.summary      = 'ZarinPal MPG In App Billing'
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
s.source = { :http => "https://github.com/ZarinPal/iOS-SDK/releases/download/#{s.version}/ZarinPalMPGFramework.zip" }

s.platform = :ios
s.ios.deployment_target = '11.0'

#s.frameworks = 'Foundation', 'UIKit'
s.vendored_frameworks  = 'ZarinPal_MPG.framework'
end
