import SwiftUI

/// Public API facade for avatar generation.
///
/// AvatarKit provides a simple, deterministic way to generate face avatars
/// from input strings. The same input will always produce the same avatar.
///
/// ## Quick Start
///
/// ```swift
/// import AvatarKit
///
/// // Generate an avatar view
/// let avatar = AvatarKit.avatar(for: "john@example.com")
///
/// // With custom size
/// let large = AvatarKit.avatar(for: "jane", size: 128)
/// ```
///
public enum AvatarKit {

    // MARK: - Quick Generation

    /// Generate an avatar view for the given input string.
    ///
    /// - Parameters:
    ///   - input: The input string to hash and generate from (e.g., username, email).
    ///   - style: The visual style for the avatar (default: `.pixel`).
    ///   - size: The size of the avatar in points (default: 64).
    /// - Returns: An AvatarView ready to display.
    @MainActor
    public static func avatar(
        for input: String,
        style: AvatarStyle = .pixel,
        size: CGFloat = 64
    ) -> AvatarView {
        let generator = ProceduralAvatarGenerator(style: style)
        return generator.avatar(for: input, size: size)
    }

    /// Generate multiple avatar views.
    ///
    /// - Parameters:
    ///   - inputs: Array of input strings.
    ///   - style: The visual style for all avatars (default: `.pixel`).
    ///   - size: The size of each avatar in points (default: 64).
    /// - Returns: Array of AvatarViews.
    @MainActor
    public static func avatars(
        for inputs: [String],
        style: AvatarStyle = .pixel,
        size: CGFloat = 64
    ) -> [AvatarView] {
        let generator = ProceduralAvatarGenerator(style: style)
        return generator.avatars(for: inputs, size: size)
    }

    // MARK: - Generator Factory

    /// Create a reusable generator with the specified style.
    ///
    /// Use this when generating multiple avatars with the same style
    /// for slightly better performance.
    ///
    /// ```swift
    /// let generator = AvatarKit.generator(style: .minimalist)
    /// let avatar1 = generator.avatar(for: "user1")
    /// let avatar2 = generator.avatar(for: "user2")
    /// ```
    ///
    /// - Parameter style: The visual style for generated avatars.
    /// - Returns: A ProceduralAvatarGenerator configured with the style.
    public static func generator(style: AvatarStyle = .pixel) -> ProceduralAvatarGenerator {
        ProceduralAvatarGenerator(style: style)
    }

    // MARK: - Data Generation

    /// Generate face data without rendering.
    ///
    /// Use this when you need the raw face data for custom rendering
    /// or analysis.
    ///
    /// - Parameters:
    ///   - input: The input string to hash and generate from.
    ///   - style: The style to use for style-specific options.
    /// - Returns: A FaceData struct containing all face attributes.
    public static func faceData(
        for input: String,
        style: AvatarStyle = .pixel
    ) -> FaceData {
        let generator = ProceduralAvatarGenerator(style: style)
        return generator.generate(for: input)
    }

    /// Generate multiple face data objects.
    ///
    /// - Parameters:
    ///   - inputs: Array of input strings.
    ///   - style: The style to use for style-specific options.
    /// - Returns: Array of FaceData objects.
    public static func faceData(
        for inputs: [String],
        style: AvatarStyle = .pixel
    ) -> [FaceData] {
        let generator = ProceduralAvatarGenerator(style: style)
        return generator.generate(for: inputs)
    }
}
