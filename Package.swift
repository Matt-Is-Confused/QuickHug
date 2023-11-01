// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "QuickHug",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "QuickHug",
            targets: ["ckdl", "QuickHug"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "QuickHug",
            dependencies: ["ckdl"]

        ),
        .target(
            name: "ckdl",
            exclude: [
                "bindings",
                "tests",
            ],
            swiftSettings: [.interoperabilityMode(.Cxx)]
        ),
        .testTarget(
            name: "QuickHugTests",
            dependencies: ["QuickHug"]
        ),
    ]
)
