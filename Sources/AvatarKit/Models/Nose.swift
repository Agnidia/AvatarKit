/// Nose shape styles.
public enum Nose: Int, Sendable, CaseIterable, Hashable {
    case small = 0
    case medium = 1
    case large = 2
    case pointed = 3
    case rounded = 4
    case button = 5

    /// Select nose style from hash byte.
    /// - Parameters:
    ///   - byte: Hash byte value.
    ///   - style: Avatar style (for future style-specific options).
    /// - Returns: Nose style determined by the byte.
    public static func from(byte: UInt8, style: AvatarStyle) -> Nose {
        let index = Int(byte) % Self.allCases.count
        return Self.allCases[index]
    }

    /// Select nose style from hash byte using default style.
    /// - Parameter byte: Hash byte value.
    /// - Returns: Nose style determined by the byte.
    public static func from(byte: UInt8) -> Nose {
        from(byte: byte, style: .cartoon)
    }
}
