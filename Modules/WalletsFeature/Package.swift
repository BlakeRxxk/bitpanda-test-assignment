// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WalletsFeature",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "WalletsFeature",
            targets: ["WalletsFeature"]),
    ],
    dependencies: [
        .package(url: "https://github.com/BlakeRxxk/swift-style-guide", branch: "main"),
        .package(path: "../BitPandaUI"),
        .package(path: "../BitPandaCore"),
    ],
    targets: [
        .target(
            name: "WalletsFeature",
            dependencies: [
                .product(name: "BitPandaUI", package: "BitPandaUI"),
                .product(name: "BitPandaCore", package: "BitPandaCore"),
            ]),
        .testTarget(
            name: "WalletsFeatureTests",
            dependencies: ["WalletsFeature"],
            resources: [.copy("Mocks/WalletsMock.json")]),
    ])
