// swift-tools-version: 6.4

import PackageDescription

// Two halves mirroring swift-foundation's modules, and one umbrella that re-exports
// both. Consumers pick the smaller half or the whole.
let package = Package(
    name: "swift-foundation-extensions",
    platforms: [
        .iOS(.v27),
        .macOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
    ],
    products: [
        .library(name: "FoundationEssentials Extensions", targets: ["FoundationEssentials Extensions"]),
        .library(name: "FoundationInternationalization Extensions", targets: ["FoundationInternationalization Extensions"]),
        .library(name: "Foundation Extensions", targets: ["Foundation Extensions"]),
    ],
    targets: [
        .target(name: "FoundationEssentials Extensions"),
        .testTarget(
            name: "FoundationEssentials Extensions Tests",
            dependencies: [.target(name: "FoundationEssentials Extensions")]
        ),
        .target(name: "FoundationInternationalization Extensions"),
        .testTarget(
            name: "FoundationInternationalization Extensions Tests",
            dependencies: [.target(name: "FoundationInternationalization Extensions")]
        ),
        .target(
            name: "Foundation Extensions",
            dependencies: [
                .target(name: "FoundationEssentials Extensions"),
                .target(name: "FoundationInternationalization Extensions"),
            ]
        ),
        .testTarget(
            name: "Foundation Extensions Tests",
            dependencies: [.target(name: "Foundation Extensions")]
        ),
    ]
)
