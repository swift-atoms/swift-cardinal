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
            name: "Cardinal Standard Library Integration",
            targets: ["Cardinal Standard Library Integration"]
        ),
        .library(
            name: "Cardinal Apple Foundation Integration",
            targets: ["Cardinal Apple Foundation Integration"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Cardinal",
            dependencies: []
        ),
        .target(
            name: "Cardinal Standard Library Integration",
            dependencies: [
                "Cardinal"
            ]
        ),
        .target(
            name: "Cardinal Apple Foundation Integration",
            dependencies: [
                "Cardinal",
                "Cardinal Standard Library Integration",
            ]
        ),
        .testTarget(
            name: "Cardinal Tests",
            dependencies: [
                "Cardinal"
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
