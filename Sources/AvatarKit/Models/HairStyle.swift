/// Hair style options.
public enum HairStyle: Int, Sendable, CaseIterable, Hashable {
    case bald = 0
    case short = 1
    case medium = 2
    case long = 3
    case curly = 4
    case wavy = 5
    case spiky = 6
    case buzz = 7
    case mohawk = 8
    case ponytail = 9
    case bun = 10
    case afro = 11

    /// Select hair style from hash byte using modulo.
    /// - Parameter byte: Hash byte value.
    /// - Returns: Hair style determined by the byte.
    public static func from(byte: UInt8) -> HairStyle {
        let index = Int(byte) % Self.allCases.count
        return Self.allCases[index]
    }
}
