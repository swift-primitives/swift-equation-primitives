// swift-tools-version: 6.3

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
            name: "Equation Primitives",
            targets: ["Equation Primitives"]
        ),
    ],
    dependencies: [
        .package(path: "../swift-property-primitives"),
        .package(path: "../swift-identity-primitives"),
    ],
    targets: [
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
                .product(name: "Property Primitives", package: "swift-property-primitives"),
                .product(name: "Identity Primitives", package: "swift-identity-primitives"),
            ]
        ),
        .target(
            name: "Equation Primitives Standard Library Integration",
            dependencies: [
                "Equation Primitives Core"
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
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
