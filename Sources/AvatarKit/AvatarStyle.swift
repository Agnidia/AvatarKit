import SwiftUI

/// Visual style for avatar rendering.
///
/// AvatarKit renders all avatars as 32×32 pixel art that scales up
/// with crisp, chunky pixels at any display size.
public enum AvatarStyle: String, Sendable, CaseIterable, Hashable {
    /// True 32×32 pixel art with crisp, chunky pixels.
    case pixel

    /// Style-specific rendering configuration.
    public var configuration: StyleConfiguration {
        StyleConfiguration(
            strokeWidth: 0,
            cornerRadius: 0,
            shadowEnabled: false,
            colorSaturation: 1.0,
            pixelGrid: 32
        )
    }
}

/// Configuration parameters for style-specific rendering.
public struct StyleConfiguration: Sendable {
    /// Stroke width for outlines (0 = no stroke).
    public let strokeWidth: CGFloat

    /// Corner radius factor (0-1).
    public let cornerRadius: CGFloat

    /// Whether to render drop shadows.
    public let shadowEnabled: Bool

    /// Color saturation multiplier (0-1).
    public let colorSaturation: CGFloat

    /// Pixel grid size (32×32 for pixel art).
    public let pixelGrid: Int?

    public init(
        strokeWidth: CGFloat,
        cornerRadius: CGFloat,
        shadowEnabled: Bool,
        colorSaturation: CGFloat,
        pixelGrid: Int?
    ) {
        self.strokeWidth = strokeWidth
        self.cornerRadius = cornerRadius
        self.shadowEnabled = shadowEnabled
        self.colorSaturation = colorSaturation
        self.pixelGrid = pixelGrid
    }
}
