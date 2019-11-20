project: clean
	swift package generate-xcodeproj --enable-code-coverage
	ruby -e "require 'xcodeproj'; Xcodeproj::Project.open('RxTexture.xcodeproj').save" || true
	pod install

clean:
	rm -rf Pods