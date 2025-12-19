/// Face outline shape.
public enum FaceShape: Int, Sendable, CaseIterable, Hashable {
    case oval = 0
    case round = 1
    case square = 2
    case heart = 3
    case oblong = 4
    case diamond = 5

    /// Select shape from hash byte using modulo.
    /// - Parameter byte: Hash byte value.
    /// - Returns: Face shape determined by the byte.
    public static func from(byte: UInt8) -> FaceShape {
        let index = Int(byte) % Self.allCases.count
        return Self.allCases[index]
    }
}
