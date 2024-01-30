// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BitPandaUI",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "BitPandaUI",
            targets: ["BitPandaUI"]),

    ],
    dependencies: [
        .package(url: "https://github.com/BlakeRxxk/swift-style-guide", branch: "main"),
        .package(url: "https://github.com/SVGKit/SVGKit", exact: "3.0.0"),
        .package(url: "https://github.com/pinterest/PINCache", exact: "3.0.2"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "BitPandaUI",
            dependencies: [
                .product(name: "SVGKitSwift", package: "SVGKit"),
                .product(name: "PINCache", package: "PINCache"),
            ]),
        .testTarget(
            name: "BitPandaUITests",
            dependencies: ["BitPandaUI"]),
    ])
