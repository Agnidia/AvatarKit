/// Eye shape styles.
public enum Eyes: Int, Sendable, CaseIterable, Hashable {
    case round = 0
    case almond = 1
    case hooded = 2
    case upturned = 3
    case downturned = 4
    case wide = 5
    case narrow = 6
    case wink = 7

    /// Select eye style from hash byte.
    /// - Parameters:
    ///   - byte: Hash byte value.
    ///   - style: Avatar style (affects available options).
    /// - Returns: Eye style determined by the byte.
    public static func from(byte: UInt8, style: AvatarStyle) -> Eyes {
        // Wink only available in cartoon style
        let cases: [Eyes] = style == .pixel
            ? Self.allCases
            : Self.allCases.filter { $0 != .wink }
        let index = Int(byte) % cases.count
        return cases[index]
    }

    /// Select eye style from hash byte using default style.
    /// - Parameter byte: Hash byte value.
    /// - Returns: Eye style determined by the byte.
    public static func from(byte: UInt8) -> Eyes {
        from(byte: byte, style: .pixel)
    }
}
