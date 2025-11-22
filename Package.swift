// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PreviewScreenshots",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "PreviewScreenshots",
            targets: ["PreviewScreenshots"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/EmergeTools/SnapshotPreviews", from: "0.11.0")
    ],
    targets: [
        .target(
            name: "PreviewScreenshots",
            dependencies: [
                .product(name: "SnapshotPreviewsCore", package: "SnapshotPreviews")
            ]
        ),
    ]
)
