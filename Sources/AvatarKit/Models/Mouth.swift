/// Mouth expression styles.
public enum Mouth: Int, Sendable, CaseIterable, Hashable {
    case smile = 0
    case neutral = 1
    case slight = 2
    case grin = 3
    case pout = 4
    case open = 5
    case smirk = 6
    case serious = 7

    /// Select mouth style from hash byte.
    /// - Parameters:
    ///   - byte: Hash byte value.
    ///   - style: Avatar style (for future style-specific options).
    /// - Returns: Mouth style determined by the byte.
    public static func from(byte: UInt8, style: AvatarStyle) -> Mouth {
        let index = Int(byte) % Self.allCases.count
        return Self.allCases[index]
    }

    /// Select mouth style from hash byte using default style.
    /// - Parameter byte: Hash byte value.
    /// - Returns: Mouth style determined by the byte.
    public static func from(byte: UInt8) -> Mouth {
        from(byte: byte, style: .pixel)
    }
}
