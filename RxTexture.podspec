#
# Be sure to run `pod lib lint RxTexture.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RxTexture'
  s.version          = '0.1.0'
  s.summary          = 'RxSwift Texture Extensions'
  s.description      = <<-DESC
RxSwift Texture Extensions
                       DESC

  s.homepage         = 'https://github.com/OhKanghoon/RxTexture'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'OhKanghoon' => 'ggaa96@naver.com' }
  s.source           = { :git => 'https://github.com/OhKanghoon/RxTexture.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'RxTexture/Classes/**/*'
  
  s.dependency 'RxSwift', '~> 5'
  s.dependency 'RxCocoa', '~> 5'
  s.dependency 'Texture', '~> 2.8'

  s.swift_version = '5.0'
end
