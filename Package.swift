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
        .library(name: "Cardinal", targets: ["Cardinal"]),
        .library(name: "Cardinal Standard Library Integration", targets: ["Cardinal Standard Library Integration"]),
        .library(name: "Cardinal Foundation Library Integration", targets: ["Cardinal Foundation Library Integration"]),
        .library(name: "Cardinal Test Support", targets: ["Cardinal Test Support"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-atoms/swift-magnitude.git", branch: "main"),
        .package(
            url: "https://github.com/swift-atoms/swift-addition.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-subtraction.git",
            branch: "main"
        ),
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
    ],
    targets: [
        .target(
            name: "Cardinal",
            dependencies: [
                .product(name: "Magnitude", package: "swift-magnitude"),
                .product(name: "Addition", package: "swift-addition"),
                .product(name: "Subtraction", package: "swift-subtraction"),
                .product(name: "Tagged", package: "swift-tagged"),
                .product(name: "Carrier", package: "swift-carrier"),
                .product(name: "Property", package: "swift-property"),
            ],
            path: "Sources/Cardinal"
        ),
        .target(
            name: "Cardinal Standard Library Integration",
            dependencies: [
                .target(name: "Cardinal"),
                .product(name: "Tagged", package: "swift-tagged"),
                .product(name: "Carrier", package: "swift-carrier"),
            ],
            path: "Sources/Cardinal Standard Library Integration"
        ),
        .target(
            name: "Cardinal Foundation Library Integration",
            dependencies: [
                .target(name: "Cardinal"),
                .target(name: "Cardinal Standard Library Integration"),
            ],
            path: "Sources/Cardinal Foundation Library Integration"
        ),
        .target(
            name: "Cardinal Test Support",
            dependencies: [
                .target(name: "Cardinal"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Cardinal Tests",
            dependencies: [
                .product(name: "Magnitude", package: "swift-magnitude"),
                .target(name: "Cardinal"),
                .product(name: "Addition", package: "swift-addition"),
                .product(name: "Subtraction", package: "swift-subtraction"),
                .product(name: "Property", package: "swift-property"),
                .product(name: "Tagged", package: "swift-tagged"),
                .product(name: "Carrier", package: "swift-carrier"),
                .target(name: "Cardinal Standard Library Integration"),
                .target(name: "Cardinal Test Support"),
                .target(name: "Cardinal Foundation Library Integration"),
            ],
            path: "Tests/Cardinal Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets {
    target.swiftSettings = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .define("SYNCHRONIZATION_AVAILABLE", .when(platforms: [.macOS, .iOS, .tvOS, .watchOS, .visionOS, .linux, .windows])),
    ]
}
