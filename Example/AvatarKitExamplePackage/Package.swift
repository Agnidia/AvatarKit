// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "AvatarKitExampleFeature",
    platforms: [.macOS(.v14)],
    products: [
        .library(
            name: "AvatarKitExampleFeature",
            targets: ["AvatarKitExampleFeature"]
        ),
    ],
    dependencies: [
        .package(name: "AvatarKit", path: "../..")
    ],
    targets: [
        .target(
            name: "AvatarKitExampleFeature",
            dependencies: [
                .product(name: "AvatarKit", package: "AvatarKit")
            ]
        ),
        .testTarget(
            name: "AvatarKitExampleFeatureTests",
            dependencies: [
                "AvatarKitExampleFeature"
            ]
        ),
    ]
)
