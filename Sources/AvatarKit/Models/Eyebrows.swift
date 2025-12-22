/// Eyebrow styles.
public enum Eyebrows: Int, Sendable, CaseIterable, Hashable {
    case natural = 0
    case arched = 1
    case straight = 2
    case thick = 3
    case thin = 4
    case raised = 5

    /// Select eyebrow style from hash byte.
    /// - Parameters:
    ///   - byte: Hash byte value.
    ///   - style: Avatar style (for future style-specific options).
    /// - Returns: Eyebrow style determined by the byte.
    public static func from(byte: UInt8, style: AvatarStyle) -> Eyebrows {
        let index = Int(byte) % Self.allCases.count
        return Self.allCases[index]
    }

    /// Select eyebrow style from hash byte using default style.
    /// - Parameter byte: Hash byte value.
    /// - Returns: Eyebrow style determined by the byte.
    public static func from(byte: UInt8) -> Eyebrows {
        from(byte: byte, style: .pixel)
    }
}
