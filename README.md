# SwiftUI Preview Screenshots

This is an example repo showing how to automatically generate and save screenshots of SwiftUI view previews.

The preview screenshot functionality is provided by [the SnapshotPreviews package](https://github.com/EmergeTools/SnapshotPreviews). This example project includes a test case that creates and saves a screenshot of each preview to the `screenshots` directory.

## Usage

```
make screenshots
```

## Can't I just use SnapshotPreviews for this?

Yes but you'll need to figure out how to process the XCTest result files to extract the screenshot assets. This library avoids the need to do so by saving the screenshots directly instead of storing them as test assets.
