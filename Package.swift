// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "union-profile-photo",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "UnionProfilePhoto",
            targets: ["UnionProfilePhoto"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/TimOliver/TOCropViewController.git", from: "2.7.4")
    ],
    targets: [
        .target(
            name: "UnionProfilePhoto",
            dependencies: [
                .product(name: "CropViewController", package: "TOCropViewController")
            ]
        ),
    ]
)
