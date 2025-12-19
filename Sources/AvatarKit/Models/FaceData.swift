import SwiftUI

/// Complete face descriptor containing all visual attributes.
public struct FaceData: Sendable, Hashable, Equatable {
    /// The overall face shape.
    public let faceShape: FaceShape

    /// The skin tone color.
    public let skinTone: SkinTone

    /// The eye shape style.
    public let eyes: Eyes

    /// The eye iris color.
    public let eyeColor: EyeColor

    /// The eyebrow style.
    public let eyebrows: Eyebrows

    /// The nose shape.
    public let nose: Nose

    /// The mouth expression.
    public let mouth: Mouth

    /// The hair style.
    public let hairStyle: HairStyle

    /// The hair color.
    public let hairColor: HairColor

    /// Optional accessories (glasses, facial hair, earrings).
    public let accessories: Accessories

    /// Create a face with all components specified.
    public init(
        faceShape: FaceShape,
        skinTone: SkinTone,
        eyes: Eyes,
        eyeColor: EyeColor,
        eyebrows: Eyebrows,
        nose: Nose,
        mouth: Mouth,
        hairStyle: HairStyle,
        hairColor: HairColor,
        accessories: Accessories
    ) {
        self.faceShape = faceShape
        self.skinTone = skinTone
        self.eyes = eyes
        self.eyeColor = eyeColor
        self.eyebrows = eyebrows
        self.nose = nose
        self.mouth = mouth
        self.hairStyle = hairStyle
        self.hairColor = hairColor
        self.accessories = accessories
    }
}
