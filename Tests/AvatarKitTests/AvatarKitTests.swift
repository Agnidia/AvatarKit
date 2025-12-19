import Testing
@testable import AvatarKit

@Suite("AvatarKit Public API Tests")
struct AvatarKitTests {

    // MARK: - Face Data Generation

    @Test("Face data generation produces valid output")
    func faceDataGeneration() {
        let faceData = AvatarKit.faceData(for: "test@example.com")

        #expect(FaceShape.allCases.contains(faceData.faceShape))
        #expect(SkinTone.allCases.contains(faceData.skinTone))
        #expect(Eyes.allCases.contains(faceData.eyes))
        #expect(EyeColor.allCases.contains(faceData.eyeColor))
        #expect(Eyebrows.allCases.contains(faceData.eyebrows))
        #expect(Nose.allCases.contains(faceData.nose))
        #expect(Mouth.allCases.contains(faceData.mouth))
        #expect(HairStyle.allCases.contains(faceData.hairStyle))
        #expect(HairColor.allCases.contains(faceData.hairColor))
    }

    @Test("Batch face data generation")
    func batchFaceDataGeneration() {
        let inputs = ["user1", "user2", "user3"]
        let faceDataArray = AvatarKit.faceData(for: inputs)

        #expect(faceDataArray.count == 3)
        #expect(faceDataArray[0] != faceDataArray[1])
        #expect(faceDataArray[1] != faceDataArray[2])
    }

    @Test("Generator factory creates valid generator")
    func generatorFactory() {
        let generator = AvatarKit.generator(style: .cartoon)
        #expect(generator.style == .cartoon)

        let minimalistGenerator = AvatarKit.generator(style: .minimalist)
        #expect(minimalistGenerator.style == .minimalist)
    }

    @Test("All styles produce valid face data")
    func allStylesProduceValidFaceData() {
        for style in AvatarStyle.allCases {
            let faceData = AvatarKit.faceData(for: "test", style: style)
            #expect(FaceShape.allCases.contains(faceData.faceShape))
        }
    }
}

@Suite("Determinism Tests")
struct DeterminismTests {

    @Test("Same input produces same output")
    func sameInputSameOutput() {
        let input = "determinism-test@example.com"

        let face1 = AvatarKit.faceData(for: input)
        let face2 = AvatarKit.faceData(for: input)

        #expect(face1 == face2)
        #expect(face1.faceShape == face2.faceShape)
        #expect(face1.skinTone == face2.skinTone)
        #expect(face1.eyes == face2.eyes)
        #expect(face1.eyeColor == face2.eyeColor)
        #expect(face1.eyebrows == face2.eyebrows)
        #expect(face1.nose == face2.nose)
        #expect(face1.mouth == face2.mouth)
        #expect(face1.hairStyle == face2.hairStyle)
        #expect(face1.hairColor == face2.hairColor)
        #expect(face1.accessories == face2.accessories)
    }

    @Test("Different inputs produce different outputs")
    func differentInputsDifferentOutputs() {
        let face1 = AvatarKit.faceData(for: "user1@example.com")
        let face2 = AvatarKit.faceData(for: "user2@example.com")

        #expect(face1 != face2)
    }

    @Test("Similar inputs produce different outputs")
    func similarInputsDifferentOutputs() {
        let face1 = AvatarKit.faceData(for: "john")
        let face2 = AvatarKit.faceData(for: "john1")
        let face3 = AvatarKit.faceData(for: "John")

        #expect(face1 != face2)
        #expect(face2 != face3)
        #expect(face1 != face3)
    }

    @Test("Determinism across multiple generations")
    func determinismAcrossGenerations() {
        let input = "consistency-check"
        var previousFace = AvatarKit.faceData(for: input)

        for _ in 0..<100 {
            let currentFace = AvatarKit.faceData(for: input)
            #expect(currentFace == previousFace)
            previousFace = currentFace
        }
    }
}

@Suite("ProceduralAvatarGenerator Tests")
struct ProceduralAvatarGeneratorTests {

    @Test("Generator produces valid face data")
    func generatorProducesValidFaceData() {
        let generator = ProceduralAvatarGenerator(style: .cartoon)
        let face = generator.generate(for: "test")

        #expect(FaceShape.allCases.contains(face.faceShape))
        #expect(SkinTone.allCases.contains(face.skinTone))
    }

    @Test("Generator style is preserved")
    func generatorStylePreserved() {
        for style in AvatarStyle.allCases {
            let generator = ProceduralAvatarGenerator(style: style)
            #expect(generator.style == style)
        }
    }

    @Test("Batch generation works correctly")
    func batchGeneration() {
        let generator = ProceduralAvatarGenerator(style: .cartoon)
        let faces = generator.generate(for: ["a", "b", "c", "d", "e"])

        #expect(faces.count == 5)

        // All should be different
        for i in 0..<faces.count {
            for j in (i+1)..<faces.count {
                #expect(faces[i] != faces[j])
            }
        }
    }

    @Test("Empty input produces consistent output")
    func emptyInput() {
        let face1 = AvatarKit.faceData(for: "")
        let face2 = AvatarKit.faceData(for: "")

        #expect(face1 == face2)
    }

    @Test("Unicode input works correctly")
    func unicodeInput() {
        let face1 = AvatarKit.faceData(for: "日本語")
        let face2 = AvatarKit.faceData(for: "日本語")
        let face3 = AvatarKit.faceData(for: "中文")

        #expect(face1 == face2)
        #expect(face1 != face3)
    }

    @Test("Emoji input works correctly")
    func emojiInput() {
        let face1 = AvatarKit.faceData(for: "👨‍💻")
        let face2 = AvatarKit.faceData(for: "👨‍💻")
        let face3 = AvatarKit.faceData(for: "👩‍💻")

        #expect(face1 == face2)
        #expect(face1 != face3)
    }
}

@Suite("FaceData Tests")
struct FaceDataTests {

    @Test("FaceData is Hashable")
    func faceDataHashable() {
        let face1 = AvatarKit.faceData(for: "test1")
        let face2 = AvatarKit.faceData(for: "test2")
        let face3 = AvatarKit.faceData(for: "test1")

        var set: Set<FaceData> = []
        set.insert(face1)
        set.insert(face2)
        set.insert(face3)

        #expect(set.count == 2) // face1 and face3 are the same
    }

    @Test("FaceData is Equatable")
    func faceDataEquatable() {
        let face1 = AvatarKit.faceData(for: "equal-test")
        let face2 = AvatarKit.faceData(for: "equal-test")
        let face3 = AvatarKit.faceData(for: "different")

        #expect(face1 == face2)
        #expect(face1 != face3)
    }
}

@Suite("Component Tests")
struct ComponentTests {

    @Test("All face shapes are selectable")
    func allFaceShapesSelectable() {
        var selectedShapes: Set<FaceShape> = []

        // Generate many faces to ensure all shapes can be selected
        for i in 0..<1000 {
            let face = AvatarKit.faceData(for: "shape-test-\(i)")
            selectedShapes.insert(face.faceShape)
        }

        #expect(selectedShapes.count == FaceShape.allCases.count)
    }

    @Test("All skin tones are selectable")
    func allSkinTonesSelectable() {
        var selectedTones: Set<SkinTone> = []

        for i in 0..<1000 {
            let face = AvatarKit.faceData(for: "tone-test-\(i)")
            selectedTones.insert(face.skinTone)
        }

        #expect(selectedTones.count == SkinTone.allCases.count)
    }

    @Test("All hair styles are selectable")
    func allHairStylesSelectable() {
        var selectedStyles: Set<HairStyle> = []

        for i in 0..<1000 {
            let face = AvatarKit.faceData(for: "hair-test-\(i)")
            selectedStyles.insert(face.hairStyle)
        }

        #expect(selectedStyles.count == HairStyle.allCases.count)
    }

    @Test("Skin tone colors are valid")
    func skinToneColorsValid() {
        for tone in SkinTone.allCases {
            // Just verify they don't crash
            _ = tone.color
            _ = tone.shadowColor
        }
    }

    @Test("Hair color colors are valid")
    func hairColorColorsValid() {
        for color in HairColor.allCases {
            _ = color.color
            _ = color.shadowColor
        }
    }

    @Test("Eye color colors are valid")
    func eyeColorColorsValid() {
        for color in EyeColor.allCases {
            _ = color.color
            _ = color.highlightColor
        }
    }
}

@Suite("Style Configuration Tests")
struct StyleConfigurationTests {

    @Test("All styles have valid configurations")
    func allStylesHaveValidConfigurations() {
        for style in AvatarStyle.allCases {
            let config = style.configuration

            #expect(config.strokeWidth >= 0)
            #expect(config.cornerRadius >= 0 && config.cornerRadius <= 1)
            #expect(config.colorSaturation >= 0 && config.colorSaturation <= 1)

            if style == .pixel {
                #expect(config.pixelGrid != nil)
            }
        }
    }

    @Test("Cartoon style has shadows enabled")
    func cartoonStyleHasShadows() {
        let config = AvatarStyle.cartoon.configuration
        #expect(config.shadowEnabled == true)
    }

    @Test("Minimalist style has shadows disabled")
    func minimalistStyleNoShadows() {
        let config = AvatarStyle.minimalist.configuration
        #expect(config.shadowEnabled == false)
    }

    @Test("Pixel style has grid defined")
    func pixelStyleHasGrid() {
        let config = AvatarStyle.pixel.configuration
        #expect(config.pixelGrid == 32)
    }
}

@Suite("Accessories Tests")
struct AccessoriesTests {

    @Test("Accessories none is empty")
    func accessoriesNoneIsEmpty() {
        let none = Accessories.none

        #expect(none.glasses == nil)
        #expect(none.facialHair == nil)
        #expect(none.earrings == nil)
    }

    @Test("Accessories can have glasses")
    func accessoriesCanHaveGlasses() {
        var hasGlasses = false

        for i in 0..<1000 {
            let face = AvatarKit.faceData(for: "glasses-test-\(i)")
            if face.accessories.glasses != nil {
                hasGlasses = true
                break
            }
        }

        #expect(hasGlasses)
    }

    @Test("Glasses have valid frame colors")
    func glassesHaveValidFrameColors() {
        for glasses in Accessories.Glasses.allCases {
            _ = glasses.frameColor
        }
    }

    @Test("Earrings have valid colors")
    func earringsHaveValidColors() {
        for earring in Accessories.Earrings.allCases {
            _ = earring.color
        }
    }
}
