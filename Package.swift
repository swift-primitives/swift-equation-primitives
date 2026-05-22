// swift-tools-version: 6.3.1

import PackageDescription

let package = Package(
    name: "swift-equation-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26),
    ],
    products: [
        .library(
            name: "Equation Namespace",
            targets: ["Equation Namespace"]
        ),
        .library(
            name: "Equation Primitives",
            targets: ["Equation Primitives"]
        ),
        .library(
            name: "Equation Primitives Core",
            targets: ["Equation Primitives Core"]
        ),
        .library(
            name: "Equation Primitives Standard Library Integration",
            targets: ["Equation Primitives Standard Library Integration"]
        ),
        .library(
            name: "Equation Primitives Test Support",
            targets: ["Equation Primitives Test Support"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-primitives/swift-property-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-tagged-primitives.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "Equation Namespace",
            dependencies: []
        ),
        .target(
            name: "Equation Primitives",
            dependencies: [
                "Equation Primitives Core",
                "Equation Primitives Standard Library Integration"
            ]
        ),
        .target(
            name: "Equation Primitives Core",
            dependencies: [
                "Equation Namespace",
                .product(name: "Property Primitives", package: "swift-property-primitives"),
                .product(name: "Tagged Primitives", package: "swift-tagged-primitives"),
            ]
        ),
        .target(
            name: "Equation Primitives Standard Library Integration",
            dependencies: [
                "Equation Primitives Core"
            ]
        ),

        // MARK: - Test Support
        .target(
            name: "Equation Primitives Test Support",
            dependencies: [
                "Equation Primitives",
                .product(name: "Tagged Primitives Test Support", package: "swift-tagged-primitives"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Equation Primitives Tests",
            dependencies: [
                "Equation Primitives",
                "Equation Primitives Test Support",
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
