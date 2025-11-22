# PreviewScreenshots

A Swift package that automatically generates and saves screenshots of all SwiftUI `#Preview` definitions in your project.

## Features

- Discovers all `#Preview` macros in your codebase
- Renders and saves each preview to a PNG file

## Installation

### XcodeGen

In your `project.yml`:

```yaml
packages:
  PreviewScreenshots:
    url: https://github.com/johnbillion/swiftui-preview-screenshots
    from: 1.0.0

targets:
  YourAppTests:
    type: bundle.unit-test
    dependencies:
      - package: PreviewScreenshots
        product: PreviewScreenshots
```

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/johnbillion/swiftui-preview-screenshots", from: "1.0.0")
]
```

Then add it to your test target:

```swift
.testTarget(
    name: "YourAppTests",
    dependencies: ["PreviewScreenshots"]
)
```

### Xcode

File → Add Package Dependencies → paste in `https://github.com/johnbillion/swiftui-preview-screenshots`.

## Usage

PreviewScreenshots has to be run as an XCTest because the underlying SnapshotPreviews library has dependencies that are only available via XCTest.

Create a test file in your test target:

```swift
import XCTest
import PreviewScreenshots

final class ScreenshotTests: XCTestCase {
    @MainActor
    func testSaveAllPreviews() throws {
        let count = try PreviewScreenshots.saveAllPreviews()
        XCTAssertGreaterThan(count, 0, "Expected at least one preview to be saved")
    }
}
```

Run the test to generate screenshots. By default, screenshots are saved to a `screenshots` directory in your project root.

### Custom Output Directory

```swift
let outputDir = URL(fileURLWithPath: "/path/to/output")
try PreviewScreenshots.saveAllPreviews(to: outputDir)
```

## Requirements

- macOS 13.0+
- Swift 6+

## How It Works

This package uses [SnapshotPreviews](https://github.com/EmergeTools/SnapshotPreviews) for preview discovery and SwiftUI's `ImageRenderer` for rendering. Unlike using SnapshotPreviews directly, this package saves screenshots as files rather than XCTest attachments, avoiding the need to extract images from `.xcresult` bundles.

## Example

This repository includes an example app with previews. To generate screenshots for the example:

```
make screenshots
```

Screenshots are saved to the `screenshots` directory.
