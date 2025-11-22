import Foundation
import SwiftUI
import AppKit
import SnapshotPreviewsCore
import UniformTypeIdentifiers

/// Discovers all SwiftUI previews and saves screenshots directly to disk.
/// Uses SnapshotPreviewsCore for preview discovery and SwiftUI's ImageRenderer for rendering.
@available(macOS 13.0, *)
@MainActor
public enum PreviewScreenshots {

    /// Discovers all previews and saves screenshots to the specified directory.
    /// - Parameter outputDirectory: Directory to save screenshots. Defaults to "screenshots" in current working directory.
    /// - Returns: Number of screenshots saved.
    @discardableResult
    public static func saveAllPreviews(to outputDirectory: URL? = nil) throws -> Int {
        let outputDir = outputDirectory ?? defaultOutputDirectory()

        // Clear existing screenshots and recreate directory
        try? FileManager.default.removeItem(at: outputDir)
        try FileManager.default.createDirectory(at: outputDir, withIntermediateDirectories: true)

        // Discover all previews
        let previewTypes = FindPreviews.findPreviews(included: nil, excluded: nil)

        var count = 0
        for previewType in previewTypes {
            for (index, preview) in previewType.previews.enumerated() {
                let filename = generateFilename(previewType: previewType, preview: preview, index: index)
                let fileURL = outputDir.appendingPathComponent(filename)

                try savePreview(preview, to: fileURL)
                print("✓ \(filename)")
                count += 1
            }
        }

        print("\n\(count) screenshots saved to \(outputDir.path)")
        return count
    }

    enum ScreenshotError: Error {
        case renderingFailed
        case encodingFailed
    }

    /// Saves a single preview to a file.
    private static func savePreview(_ preview: SnapshotPreviewsCore.Preview, to url: URL) throws {
        let view = AnyView(preview.view())

        // Wrap the view with colour scheme awareness
        let wrappedView = ColorSchemeAwareBackground {
            view
        }
        let renderer = ImageRenderer(content: wrappedView)
        renderer.scale = 2.0  // Retina

        guard let cgImage = renderer.cgImage else {
            throw ScreenshotError.renderingFailed
        }

        // Write CGImage directly to PNG
        guard let destination = CGImageDestinationCreateWithURL(url as CFURL, UTType.png.identifier as CFString, 1, nil) else {
            throw ScreenshotError.encodingFailed
        }
        CGImageDestinationAddImage(destination, cgImage, nil)
        guard CGImageDestinationFinalize(destination) else {
            throw ScreenshotError.encodingFailed
        }
    }

    /// Generates a filename for a preview.
    private static func generateFilename(previewType: PreviewType, preview: SnapshotPreviewsCore.Preview, index: Int) -> String {
        var baseName = previewType.displayName.replacingOccurrences(of: " ", with: "_")
        if baseName.hasSuffix("_View") {
            baseName = String(baseName.dropLast(5))
        }

        if let displayName = preview.displayName {
            let previewName = displayName.replacingOccurrences(of: " ", with: "_")
            return "\(baseName)_\(previewName).png"
        } else if previewType.previews.count > 1 {
            return "\(baseName)_\(index).png"
        } else {
            return "\(baseName).png"
        }
    }

    /// Returns the default output directory (screenshots folder in project root).
    /// Uses #file to reliably locate the project directory at compile time.
    private static func defaultOutputDirectory() -> URL {
        // #file gives us the path to this source file (e.g., /path/to/project/ExampleTests/PreviewScreenshots.swift)
        // Go up one level to get the project root
        URL(fileURLWithPath: #file)
            .deletingLastPathComponent()  // ExampleTests/
            .deletingLastPathComponent()  // project root
            .appendingPathComponent("screenshots")
    }
}

/// A wrapper view that detects the preferred color scheme and applies an appropriate background.
/// Uses PreferredColorSchemeWrapper to capture .preferredColorScheme() from child views.
@available(macOS 13.0, *)
private struct ColorSchemeAwareBackground<Content: View>: View {
    @State private var detectedScheme: ColorScheme?
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        let effectiveScheme = detectedScheme ?? .light

        ZStack {
            backgroundColorForScheme(effectiveScheme)
            PreferredColorSchemeWrapper({
                content
            }, colorSchemeUpdater: { scheme in
                detectedScheme = scheme
            })
        }
        .environment(\.colorScheme, effectiveScheme)
    }

    private func backgroundColorForScheme(_ scheme: ColorScheme) -> Color {
        let appearance: NSAppearance? = scheme == .dark
            ? NSAppearance(named: .darkAqua)
            : NSAppearance(named: .aqua)

        var resolvedColor: NSColor = .windowBackgroundColor
        appearance?.performAsCurrentDrawingAppearance {
            resolvedColor = NSColor.windowBackgroundColor
        }
        return Color(nsColor: resolvedColor)
    }
}
