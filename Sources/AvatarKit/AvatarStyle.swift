import SwiftUI

/// Visual style for avatar rendering.
public enum AvatarStyle: String, Sendable, CaseIterable, Hashable {
    /// Colorful, rounded, expressive avatars.
    case cartoon

    /// Simple lines, limited colors, clean look.
    case minimalist

    /// Retro pixel art style (32x32 grid).
    case pixel

    /// Abstract shapes, flat colors, modern aesthetic.
    case geometric

    /// Style-specific rendering configuration.
    public var configuration: StyleConfiguration {
        switch self {
        case .cartoon:
            StyleConfiguration(
                strokeWidth: 2,
                cornerRadius: 0.3,
                shadowEnabled: true,
                colorSaturation: 1.0,
                pixelGrid: nil
            )
        case .minimalist:
            StyleConfiguration(
                strokeWidth: 1,
                cornerRadius: 0.1,
                shadowEnabled: false,
                colorSaturation: 0.4,
                pixelGrid: nil
            )
        case .pixel:
            StyleConfiguration(
                strokeWidth: 0,
                cornerRadius: 0,
                shadowEnabled: false,
                colorSaturation: 1.0,
                pixelGrid: 32
            )
        case .geometric:
            StyleConfiguration(
                strokeWidth: 0,
                cornerRadius: 0,
                shadowEnabled: false,
                colorSaturation: 0.8,
                pixelGrid: nil
            )
        }
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

    /// Pixel grid size for pixel style (nil = vector).
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
