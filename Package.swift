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
            name: "Cardinal Primitive",
            targets: ["Cardinal Primitive"]
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

        .library(
            name: "Cardinal",
            targets: ["Cardinal"]
        ),

        .library(
            name: "Cardinal Test Support",
            targets: ["Cardinal Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-molecules/swift-tagged.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-carrier.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-property.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-equation.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-hash.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-comparison.git",
            branch: "main"
        ),
    ],
    targets: [

        .target(
            name: "Cardinal Primitive",
            dependencies: []
        ),

        .target(
            name: "Cardinal Error",
            dependencies: [
                "Cardinal Primitive"
            ]
        ),
        .target(
            name: "Cardinal Add",
            dependencies: [
                "Cardinal Primitive",
                "Cardinal Error",
                .product(name: "Property", package: "swift-property"),
            ]
        ),
        .target(
            name: "Cardinal Subtract",
            dependencies: [
                "Cardinal Primitive",
                "Cardinal Carrier",
                "Cardinal Error",
                .product(name: "Property", package: "swift-property"),
            ]
        ),
        .target(
            name: "Cardinal Carrier",
            dependencies: [
                "Cardinal Primitive",
                .product(name: "Carrier", package: "swift-carrier"),
            ]
        ),
        .target(
            name: "Cardinal Equation",
            dependencies: [
                "Cardinal Primitive",
                .product(name: "Equation", package: "swift-equation"),
            ]
        ),
        .target(
            name: "Cardinal Hash",
            dependencies: [
                "Cardinal Primitive",
                .product(name: "Hash", package: "swift-hash"),
            ]
        ),
        .target(
            name: "Cardinal Comparison",
            dependencies: [
                "Cardinal Primitive",
                .product(name: "Comparison", package: "swift-comparison"),
            ]
        ),
        .target(
            name: "Cardinal Tagged",
            dependencies: [
                "Cardinal Primitive",
                "Cardinal Error",
                "Cardinal Add",
                "Cardinal Subtract",
                .product(name: "Property", package: "swift-property"),
                .product(name: "Tagged", package: "swift-tagged"),
            ]
        ),

        .target(
            name: "Cardinal Standard Library Integration",
            dependencies: [
                "Cardinal Primitive",
                "Cardinal Error",
                "Cardinal Carrier",
                .product(name: "Carrier", package: "swift-carrier"),
                .product(name: "Tagged", package: "swift-tagged"),
                .product(
                    name: "Tagged Standard Library Integration",
                    package: "swift-tagged"
                ),
            ]
        ),

        .target(
            name: "Cardinal",
            dependencies: [
                "Cardinal Primitive",
                "Cardinal Error",
                "Cardinal Add",
                "Cardinal Subtract",
                "Cardinal Carrier",
                "Cardinal Equation",
                "Cardinal Hash",
                "Cardinal Comparison",
                "Cardinal Tagged",
                "Cardinal Standard Library Integration",
                .product(name: "Tagged", package: "swift-tagged"),
            ]
        ),

        .target(
            name: "Cardinal Test Support",
            dependencies: [
                "Cardinal",
                .product(
                    name: "Tagged Test Support",
                    package: "swift-tagged"
                ),
            ],
            path: "Tests/Support"
        ),

        .testTarget(
            name: "Cardinal Tests",
            dependencies: [
                "Cardinal",
                "Cardinal Test Support",
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
