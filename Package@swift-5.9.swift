// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let swiftSettings: Array<SwiftSetting> = [
    .enableUpcomingFeature("ConciseMagicFile"),
    .enableUpcomingFeature("ExistentialAny"),
    .enableUpcomingFeature("BareSlashRegexLiterals"),
    .enableUpcomingFeature("DisableOutwardActorInference"),
    .enableExperimentalFeature("StrictConcurrency"),
//    .enableExperimentalFeature("AccessLevelOnImport"),
//    .enableExperimentalFeature("VariadicGenerics"),
]


let package = Package(
    name: "app-groups",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "AppGroups",
            targets: ["AppGroups"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "AppGroups",
            swiftSettings: swiftSettings),
        .testTarget(
            name: "AppGroupsTests",
            dependencies: ["AppGroups"],
            swiftSettings: swiftSettings),
    ]
)
