// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Logging",
    products: [
        .library(name: "Logging", targets: ["Logging"])
    ],
    targets: [
        .target(
            name: "Logging",
            dependencies: []),
        .testTarget(
            name: "LoggingTests",
            dependencies: ["Logging"])
    ]
)
