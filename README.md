# swift-log

This repo supports logging

1. Console Logging
2. File Logging and sync each configurable timeInterval

## Log Level supports

1. 🗣 Verbose: A verbose message, usually useful when working on a specific problem
2. 🔍 Debug: A debug message that may be useful to a developer
3. ℹ️ Info: An info message that highlight the progress of the application at coarse-grained level.
4. ⚠️ Warning: A warning message, may indicate a possible error
5. ❗️ Error: An error occurred, but it's recoverable, just info about what happened
6. 🛑 Severe: A server error occurred

## Prerequisite (Developer only)

- *[SwiftLint](https://github.com/realm/SwiftLint)* enforce Swift style and conventions. Install via Homebrew: ```$ brew install swiftlint```
- *Standardize* development mode ```$ ./Scripts/setup.sh```

## Requirements
- Xcode 11.4.1+
- Swift 5.0

## How
### Setup
1. Use Framework's default setup
```
import UIKit
import Logging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        /// Setup Logging
        LoggerManager.sharedInstance.initialize()
        return true
    }
}
```
2. Customize Logging
```
import UIKit
import Logging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        /// Setup Logging
        let logFormatter = LogFormatterImpl()
        LoggerManager.sharedInstance.addLogging(LoggerFactoryImpl.makeConsoleLogging(logFormatter: logFormatter))
        LoggerManager.sharedInstance.addLogging(LoggerFactoryImpl.makeFileLogging(fileName: "logs"))
        /// Disable LogLevels. Enable all LogLevels by default
        LoggerManager.sharedInstance.disableLogLevels([LogLevel.info, LogLevel.error])

        return true
    }
}
```
### Use
```
Log.info(message: "info")
Log.debug(message: "debug")
Log.verbose(message: "verbose")
Log.warning(message: "warning")
Log.error(message: "error")
Log.severe(message: "severe")
```

## Installation

There are two ways to install `swift-log`

### CocoaPods

Just add to your project's `Podfile`:

```
github "lengocduy/swift-log"
```

### Carthage

Add following to `Cartfile`:

```
github "lengocduy/swift-log"
```

## Architecture

![Architecture](ArchDiagram.png)