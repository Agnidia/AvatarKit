import SwiftUI

/// Eye color palette.
public enum EyeColor: Int, Sendable, CaseIterable, Hashable {
    case brown = 0
    case hazel = 1
    case amber = 2
    case green = 3
    case blue = 4
    case gray = 5
    case violet = 6
    case black = 7

    /// The primary color value for this eye color.
    public var color: Color {
        switch self {
        case .brown: Color(red: 0.40, green: 0.26, blue: 0.13)
        case .hazel: Color(red: 0.55, green: 0.45, blue: 0.25)
        case .amber: Color(red: 0.70, green: 0.50, blue: 0.20)
        case .green: Color(red: 0.25, green: 0.50, blue: 0.30)
        case .blue: Color(red: 0.25, green: 0.45, blue: 0.70)
        case .gray: Color(red: 0.50, green: 0.55, blue: 0.60)
        case .violet: Color(red: 0.50, green: 0.30, blue: 0.60)
        case .black: Color(red: 0.15, green: 0.12, blue: 0.10)
        }
    }

    /// A lighter shade for highlights.
    public var highlightColor: Color {
        switch self {
        case .brown: Color(red: 0.55, green: 0.40, blue: 0.25)
        case .hazel: Color(red: 0.70, green: 0.60, blue: 0.40)
        case .amber: Color(red: 0.85, green: 0.65, blue: 0.35)
        case .green: Color(red: 0.40, green: 0.65, blue: 0.45)
        case .blue: Color(red: 0.40, green: 0.60, blue: 0.85)
        case .gray: Color(red: 0.65, green: 0.70, blue: 0.75)
        case .violet: Color(red: 0.65, green: 0.45, blue: 0.75)
        case .black: Color(red: 0.30, green: 0.27, blue: 0.25)
        }
    }

    /// Select eye color from hash byte using modulo.
    /// - Parameter byte: Hash byte value.
    /// - Returns: Eye color determined by the byte.
    public static func from(byte: UInt8) -> EyeColor {
        let index = Int(byte) % Self.allCases.count
        return Self.allCases[index]
    }
}
