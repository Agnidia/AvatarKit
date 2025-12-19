import SwiftUI

/// Hair color palette.
public enum HairColor: Int, Sendable, CaseIterable, Hashable {
    case black = 0
    case darkBrown = 1
    case brown = 2
    case auburn = 3
    case red = 4
    case strawberry = 5
    case blonde = 6
    case platinum = 7
    case gray = 8
    case white = 9

    /// The color value for this hair color.
    public var color: Color {
        switch self {
        case .black: Color(red: 0.10, green: 0.08, blue: 0.08)
        case .darkBrown: Color(red: 0.25, green: 0.18, blue: 0.12)
        case .brown: Color(red: 0.45, green: 0.30, blue: 0.18)
        case .auburn: Color(red: 0.55, green: 0.25, blue: 0.15)
        case .red: Color(red: 0.70, green: 0.25, blue: 0.15)
        case .strawberry: Color(red: 0.85, green: 0.50, blue: 0.35)
        case .blonde: Color(red: 0.90, green: 0.75, blue: 0.50)
        case .platinum: Color(red: 0.95, green: 0.92, blue: 0.85)
        case .gray: Color(red: 0.60, green: 0.60, blue: 0.60)
        case .white: Color(red: 0.95, green: 0.95, blue: 0.95)
        }
    }

    /// A slightly darker shade for depth/shadow.
    public var shadowColor: Color {
        switch self {
        case .black: Color(red: 0.05, green: 0.03, blue: 0.03)
        case .darkBrown: Color(red: 0.18, green: 0.11, blue: 0.05)
        case .brown: Color(red: 0.35, green: 0.20, blue: 0.08)
        case .auburn: Color(red: 0.45, green: 0.15, blue: 0.05)
        case .red: Color(red: 0.60, green: 0.15, blue: 0.05)
        case .strawberry: Color(red: 0.75, green: 0.40, blue: 0.25)
        case .blonde: Color(red: 0.80, green: 0.65, blue: 0.40)
        case .platinum: Color(red: 0.85, green: 0.82, blue: 0.75)
        case .gray: Color(red: 0.50, green: 0.50, blue: 0.50)
        case .white: Color(red: 0.85, green: 0.85, blue: 0.85)
        }
    }

    /// Select hair color from hash byte using modulo.
    /// - Parameter byte: Hash byte value.
    /// - Returns: Hair color determined by the byte.
    public static func from(byte: UInt8) -> HairColor {
        let index = Int(byte) % Self.allCases.count
        return Self.allCases[index]
    }
}
