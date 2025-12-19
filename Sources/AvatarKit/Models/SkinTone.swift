import SwiftUI

/// Natural skin tone palette with diverse representation.
public enum SkinTone: Int, Sendable, CaseIterable, Hashable {
    case porcelain = 0
    case ivory = 1
    case sand = 2
    case honey = 3
    case caramel = 4
    case chestnut = 5
    case espresso = 6
    case cocoa = 7

    /// The color value for this skin tone.
    public var color: Color {
        switch self {
        case .porcelain: Color(red: 1.00, green: 0.88, blue: 0.82)
        case .ivory: Color(red: 0.96, green: 0.82, blue: 0.73)
        case .sand: Color(red: 0.91, green: 0.77, blue: 0.66)
        case .honey: Color(red: 0.83, green: 0.65, blue: 0.46)
        case .caramel: Color(red: 0.72, green: 0.50, blue: 0.29)
        case .chestnut: Color(red: 0.55, green: 0.33, blue: 0.14)
        case .espresso: Color(red: 0.42, green: 0.27, blue: 0.14)
        case .cocoa: Color(red: 0.29, green: 0.16, blue: 0.07)
        }
    }

    /// A slightly darker shade for shadows/contours.
    public var shadowColor: Color {
        switch self {
        case .porcelain: Color(red: 0.90, green: 0.78, blue: 0.72)
        case .ivory: Color(red: 0.86, green: 0.72, blue: 0.63)
        case .sand: Color(red: 0.81, green: 0.67, blue: 0.56)
        case .honey: Color(red: 0.73, green: 0.55, blue: 0.36)
        case .caramel: Color(red: 0.62, green: 0.40, blue: 0.19)
        case .chestnut: Color(red: 0.45, green: 0.23, blue: 0.04)
        case .espresso: Color(red: 0.32, green: 0.17, blue: 0.04)
        case .cocoa: Color(red: 0.19, green: 0.06, blue: 0.00)
        }
    }

    /// Select skin tone from hash byte using modulo.
    /// - Parameter byte: Hash byte value.
    /// - Returns: Skin tone determined by the byte.
    public static func from(byte: UInt8) -> SkinTone {
        let index = Int(byte) % Self.allCases.count
        return Self.allCases[index]
    }
}
