import SwiftUI

/// SwiftUI view that renders a pixel art face avatar.
///
/// Example:
/// ```swift
/// AvatarView(faceData: faceData, size: 64)
/// ```
public struct AvatarView: View, Sendable {
    /// The face data to render.
    public let faceData: FaceData

    /// The rendering style (pixel art only).
    public let style: AvatarStyle

    /// The size of the avatar (width and height).
    public let size: CGFloat

    /// Create an avatar view.
    /// - Parameters:
    ///   - faceData: The face data to render.
    ///   - style: The visual style (default: .pixel).
    ///   - size: The size in points (default: 64).
    public init(faceData: FaceData, style: AvatarStyle = .pixel, size: CGFloat = 64) {
        self.faceData = faceData
        self.style = style
        self.size = size
    }

    public var body: some View {
        let renderer = PixelAvatarRenderer(gridSize: 32)
        if let cgImage = renderer.render(faceData) {
            Image(decorative: cgImage, scale: 1.0)
                .interpolation(.none) // CRITICAL: Preserve crisp pixels when scaling
                .resizable()
                .frame(width: size, height: size)
                .clipShape(Circle())
                .background(Circle().fill(Color.white.opacity(0.1)))
        } else {
            // Fallback if rendering fails
            Circle()
                .fill(faceData.skinTone.color)
                .frame(width: size, height: size)
        }
    }
}
