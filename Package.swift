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
        // MARK: - Namespace
        .library(
            name: "Equation Namespace",
            targets: ["Equation Namespace"]
        ),

        // MARK: - Sub-namespace targets
        .library(
            name: "Equation Protocol Primitives",
            targets: ["Equation Protocol Primitives"]
        ),
        .library(
            name: "Equation Tagged Primitives",
            targets: ["Equation Tagged Primitives"]
        ),

        // MARK: - StdLib Integration
        .library(
            name: "Equation Primitives Standard Library Integration",
            targets: ["Equation Primitives Standard Library Integration"]
        ),

        // MARK: - Umbrella
        .library(
            name: "Equation Primitives",
            targets: ["Equation Primitives"]
        ),

        // MARK: - Test Support
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
        // MARK: - Namespace
        .target(
            name: "Equation Namespace",
            dependencies: []
        ),

        // MARK: - Sub-namespace targets (per [MOD-031])
        .target(
            name: "Equation Protocol Primitives",
            dependencies: [
                "Equation Namespace",
            ]
        ),
        .target(
            name: "Equation Tagged Primitives",
            dependencies: [
                "Equation Protocol Primitives",
                .product(name: "Tagged Primitives", package: "swift-tagged-primitives"),
            ]
        ),

        // MARK: - StdLib Integration
        .target(
            name: "Equation Primitives Standard Library Integration",
            dependencies: [
                "Equation Protocol Primitives",
            ]
        ),

        // MARK: - Umbrella
        .target(
            name: "Equation Primitives",
            dependencies: [
                "Equation Namespace",
                "Equation Protocol Primitives",
                "Equation Tagged Primitives",
                "Equation Primitives Standard Library Integration",
                .product(name: "Property Primitives", package: "swift-property-primitives"),
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
