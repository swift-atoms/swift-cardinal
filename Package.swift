// swift-tools-version: 6.4
import PackageDescription

let package = Package(
    name: "swift-cardinal",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [

        .library(
            name: "Cardinal",
            targets: ["Cardinal"]
        ),

        .library(
            name: "Cardinal Error",
            targets: ["Cardinal Error"]
        ),
        .library(
            name: "Cardinal Add",
            targets: ["Cardinal Add"]
        ),
        .library(
            name: "Cardinal Subtract",
            targets: ["Cardinal Subtract"]
        ),
        .library(
            name: "Cardinal Carrier",
            targets: ["Cardinal Carrier"]
        ),
        .library(
            name: "Cardinal Equation",
            targets: ["Cardinal Equation"]
        ),
        .library(
            name: "Cardinal Hash",
            targets: ["Cardinal Hash"]
        ),
        .library(
            name: "Cardinal Comparison",
            targets: ["Cardinal Comparison"]
        ),
        .library(
            name: "Cardinal Tagged",
            targets: ["Cardinal Tagged"]
        ),

        .library(
            name: "Cardinal Standard Library Integration",
            targets: ["Cardinal Standard Library Integration"]
        ),

    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-tagged.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-carrier.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-property.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-equation.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-hash.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-comparison.git",
            branch: "main"
        ),
    ],
    targets: [

        .target(
            name: "Cardinal",
            dependencies: []
        ),

        .target(
            name: "Cardinal Error",
            dependencies: [
                .target(name: "Cardinal")
            ]
        ),
        .target(
            name: "Cardinal Add",
            dependencies: [
                .target(name: "Cardinal"),
                .target(name: "Cardinal Error"),
                .product(name: "Property", package: "swift-property"),
            ]
        ),
        .target(
            name: "Cardinal Subtract",
            dependencies: [
                .target(name: "Cardinal"),
                .target(name: "Cardinal Carrier"),
                .target(name: "Cardinal Error"),
                .product(name: "Property", package: "swift-property"),
            ]
        ),
        .target(
            name: "Cardinal Carrier",
            dependencies: [
                .target(name: "Cardinal"),
                .product(name: "Carrier Protocol", package: "swift-carrier"),
            ]
        ),
        .target(
            name: "Cardinal Equation",
            dependencies: [
                .target(name: "Cardinal"),
                .product(name: "Equation Protocol", package: "swift-equation"),
            ]
        ),
        .target(
            name: "Cardinal Hash",
            dependencies: [
                .target(name: "Cardinal"),
                .product(name: "Hash Protocol", package: "swift-hash"),
            ]
        ),
        .target(
            name: "Cardinal Comparison",
            dependencies: [
                .target(name: "Cardinal"),
                .product(name: "Comparison Protocol", package: "swift-comparison"),
            ]
        ),
        .target(
            name: "Cardinal Tagged",
            dependencies: [
                .target(name: "Cardinal"),
                .target(name: "Cardinal Error"),
                .target(name: "Cardinal Add"),
                .target(name: "Cardinal Subtract"),
                .product(name: "Property", package: "swift-property"),
                .product(name: "Tagged", package: "swift-tagged"),
            ]
        ),

        .target(
            name: "Cardinal Standard Library Integration",
            dependencies: [
                .target(name: "Cardinal"),
                .target(name: "Cardinal Error"),
                .target(name: "Cardinal Carrier"),
                .product(name: "Carrier Protocol", package: "swift-carrier"),
                .product(name: "Tagged", package: "swift-tagged"),
                .product(
                    name: "Tagged Standard Library Integration",
                    package: "swift-tagged"
                ),
            ]
        ),

        .testTarget(
            name: "Cardinal Tests",
            dependencies: [
                .target(name: "Cardinal"),
            ]
        ),
        .testTarget(
            name: "Cardinal Error Tests",
            dependencies: [.target(name: "Cardinal Error")]
        ),
        .testTarget(
            name: "Cardinal Add Tests",
            dependencies: [.target(name: "Cardinal Add")]
        ),
        .testTarget(
            name: "Cardinal Subtract Tests",
            dependencies: [.target(name: "Cardinal Subtract")]
        ),
        .testTarget(
            name: "Cardinal Carrier Tests",
            dependencies: [.target(name: "Cardinal Carrier")]
        ),
        .testTarget(
            name: "Cardinal Equation Tests",
            dependencies: [.target(name: "Cardinal Equation")]
        ),
        .testTarget(
            name: "Cardinal Hash Tests",
            dependencies: [.target(name: "Cardinal Hash")]
        ),
        .testTarget(
            name: "Cardinal Comparison Tests",
            dependencies: [.target(name: "Cardinal Comparison")]
        ),
        .testTarget(
            name: "Cardinal Tagged Tests",
            dependencies: [.target(name: "Cardinal Tagged")]
        ),
        .testTarget(
            name: "Cardinal Standard Library Integration Tests",
            dependencies: [
                .target(name: "Cardinal Standard Library Integration"),
                .target(name: "Cardinal Add"),
                .target(name: "Cardinal Subtract"),
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
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = [
        .define(
            "SYNCHRONIZATION_AVAILABLE",
            .when(platforms: [.macOS, .iOS, .tvOS, .watchOS, .visionOS, .linux, .windows])
        )
    ]

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
