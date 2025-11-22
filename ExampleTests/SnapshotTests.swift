import XCTest

final class PreviewScreenshotTests: XCTestCase {

    @MainActor
    func testSaveAllPreviews() throws {
        let count = try PreviewScreenshots.saveAllPreviews()
        XCTAssertGreaterThan(count, 0, "Expected at least one preview to be saved")
    }
}
