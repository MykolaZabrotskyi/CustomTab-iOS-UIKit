// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "CustomTab",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "CustomTab",
            targets: ["CustomTab"]
        ),
    ],
    targets: [
        .target(
            name: "CustomTab"
        ),
        
    ]
)
