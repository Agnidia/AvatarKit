import SwiftUI

/// Protocol for avatar generators, enabling custom implementations.
public protocol AvatarGenerating: Sendable {
    /// The style used for generation.
    var style: AvatarStyle { get }

    /// Generate face data for the given input string.
    /// - Parameter input: The input string to hash and generate from.
    /// - Returns: A complete face data descriptor.
    func generate(for input: String) -> FaceData
}

// MARK: - Protocol Extensions

public extension AvatarGenerating {
    /// Generate an avatar view for the given input.
    /// - Parameters:
    ///   - input: The input string to generate from.
    ///   - size: The size of the avatar view (default: 64).
    /// - Returns: An AvatarView configured with the generated face data.
    @MainActor
    func avatar(for input: String, size: CGFloat = 64) -> AvatarView {
        AvatarView(faceData: generate(for: input), style: style, size: size)
    }

    /// Generate multiple face data objects.
    /// - Parameter inputs: Array of input strings.
    /// - Returns: Array of face data objects.
    func generate(for inputs: [String]) -> [FaceData] {
        inputs.map { generate(for: $0) }
    }

    /// Generate multiple avatar views.
    /// - Parameters:
    ///   - inputs: Array of input strings.
    ///   - size: The size of each avatar view (default: 64).
    /// - Returns: Array of avatar views.
    @MainActor
    func avatars(for inputs: [String], size: CGFloat = 64) -> [AvatarView] {
        inputs.map { avatar(for: $0, size: size) }
    }
}
