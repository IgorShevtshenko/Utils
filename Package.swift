// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Utils",
    platforms: [.iOS(.v17), .macOS(.v10_15)],
    products: [
        .library(
            name: "Utils",
            targets: [
                "Utils",
                "Presentation",
            ]
        ),
    ],
    targets: [
        .target(name: "Utils"),
        .target(
            name: "Presentation",
            dependencies: ["Utils"]
        ),
    ]
)
