import SwiftUI

/// Optional face accessories.
public struct Accessories: Sendable, Hashable {
    public let glasses: Glasses?
    public let facialHair: FacialHair?
    public let earrings: Earrings?

    public init(glasses: Glasses? = nil, facialHair: FacialHair? = nil, earrings: Earrings? = nil) {
        self.glasses = glasses
        self.facialHair = facialHair
        self.earrings = earrings
    }

    /// No accessories.
    public static let none = Accessories()

    /// Glasses styles.
    public enum Glasses: Int, Sendable, CaseIterable, Hashable {
        case round = 0
        case rectangular = 1
        case aviator = 2
        case catEye = 3
        case rimless = 4

        /// Frame color.
        public var frameColor: Color {
            switch self {
            case .round: Color(red: 0.2, green: 0.2, blue: 0.2)
            case .rectangular: Color(red: 0.1, green: 0.1, blue: 0.15)
            case .aviator: Color(red: 0.6, green: 0.55, blue: 0.4)
            case .catEye: Color(red: 0.4, green: 0.2, blue: 0.3)
            case .rimless: Color(red: 0.7, green: 0.7, blue: 0.7)
            }
        }

        public static func from(byte: UInt8) -> Glasses {
            let index = Int(byte) % Self.allCases.count
            return Self.allCases[index]
        }
    }

    /// Facial hair styles.
    public enum FacialHair: Int, Sendable, CaseIterable, Hashable {
        case stubble = 0
        case goatee = 1
        case fullBeard = 2
        case mustache = 3
        case soulPatch = 4

        public static func from(byte: UInt8) -> FacialHair {
            let index = Int(byte) % Self.allCases.count
            return Self.allCases[index]
        }
    }

    /// Earring styles.
    public enum Earrings: Int, Sendable, CaseIterable, Hashable {
        case studs = 0
        case hoops = 1
        case dangles = 2

        /// Earring color.
        public var color: Color {
            switch self {
            case .studs: Color(red: 0.85, green: 0.75, blue: 0.45)
            case .hoops: Color(red: 0.75, green: 0.75, blue: 0.80)
            case .dangles: Color(red: 0.85, green: 0.75, blue: 0.45)
            }
        }

        public static func from(byte: UInt8) -> Earrings {
            let index = Int(byte) % Self.allCases.count
            return Self.allCases[index]
        }
    }

    /// Generate accessories from hash bytes.
    /// - Parameters:
    ///   - bytes: Three bytes for glasses, facial hair, and earrings.
    ///   - style: Avatar style.
    /// - Returns: Accessories determined by the bytes.
    public static func from(bytes: [UInt8], style: AvatarStyle) -> Accessories {
        guard bytes.count >= 3 else { return .none }

        // ~33% chance for each accessory type
        let glasses: Glasses? = bytes[0] % 3 == 0 ? Glasses.from(byte: bytes[0]) : nil
        let facialHair: FacialHair? = bytes[1] % 3 == 0 ? FacialHair.from(byte: bytes[1]) : nil
        let earrings: Earrings? = bytes[2] % 3 == 0 ? Earrings.from(byte: bytes[2]) : nil

        return Accessories(glasses: glasses, facialHair: facialHair, earrings: earrings)
    }
}
