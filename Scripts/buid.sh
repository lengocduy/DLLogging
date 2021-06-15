# 1. Remove existing xcframework bundle
test -d DLLogging.xcframework && rm -rf "$PWD/DLLogging.xcframework"

# 2. Build all the supported architectures
## Device slice.
xcodebuild clean archive -scheme DLLogging CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO -sdk iphoneos  -configuration Release -destination 'generic/platform=iOS' -archivePath "$PWD/archives/DLLogging.framework-iphoneos.xcarchive" SKIP_INSTALL=NO

## Simulator slice.
xcodebuild clean archive -scheme DLLogging CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO -sdk iphonesimulator -configuration Release -destination 'generic/platform=iOS Simulator' -archivePath "$PWD/archives/DLLogging.framework-iphonesimulator.xcarchive" SKIP_INSTALL=NO

## Mac Catalyst slice.
xcodebuild clean archive -scheme DLLogging -configuration Release -archivePath "$PWD/archives/DLLogging.framework-catalyst.xcarchive" SKIP_INSTALL=NO

# 3. Create a XCFramework to combine all the supported architectures in a bundle
xcodebuild -create-xcframework -framework "$PWD/archives/DLLogging.framework-iphonesimulator.xcarchive/Products/Library/Frameworks/DLLogging.framework" -framework "$PWD/archives/DLLogging.framework-iphoneos.xcarchive/Products/Library/Frameworks/DLLogging.framework" -framework "$PWD/archives/DLLogging.framework-catalyst.xcarchive/Products/Library/Frameworks/DLLogging.framework" -output "$PWD/DLLogging.xcframework"

# 4. Remove temporay folder to take the space back
rm -rf "$PWD/archives"