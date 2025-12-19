/// Hash-based procedural avatar generator.
///
/// Generates deterministic face avatars by hashing input strings and using
/// the hash bytes to select face components.
///
/// Example:
/// ```swift
/// let generator = ProceduralAvatarGenerator(style: .cartoon)
/// let face = generator.generate(for: "john@example.com")
/// ```
public struct ProceduralAvatarGenerator: AvatarGenerating, Sendable {
    /// The style used for generation.
    public let style: AvatarStyle

    /// Create a generator with the specified style.
    /// - Parameter style: The visual style for generated avatars (default: .cartoon).
    public init(style: AvatarStyle = .cartoon) {
        self.style = style
    }

    /// Generate face data for the given input string.
    ///
    /// The same input will always produce the same face data (deterministic).
    ///
    /// - Parameter input: The input string to hash and generate from.
    /// - Returns: A complete face data descriptor.
    public func generate(for input: String) -> FaceData {
        let hash = HashSource.sha256(input)
        var reader = ByteReader(bytes: hash)

        return FaceData(
            faceShape: FaceShape.from(byte: reader.next()),
            skinTone: SkinTone.from(byte: reader.next()),
            eyes: Eyes.from(byte: reader.next(), style: style),
            eyeColor: EyeColor.from(byte: reader.next()),
            eyebrows: Eyebrows.from(byte: reader.next(), style: style),
            nose: Nose.from(byte: reader.next(), style: style),
            mouth: Mouth.from(byte: reader.next(), style: style),
            hairStyle: HairStyle.from(byte: reader.next()),
            hairColor: HairColor.from(byte: reader.next()),
            accessories: Accessories.from(bytes: reader.nextBytes(3), style: style)
        )
    }
}
