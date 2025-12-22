import CoreGraphics

/// Pixel art patterns for all facial features at 32x32 resolution.
///
/// All patterns are designed for a 32x32 grid with the face centered.
/// Coordinates use top-left origin (0,0) matching CGContext after flip.
enum PixelPatterns {
    // MARK: - Face Shapes

    /// Returns pixels to fill for each face shape.
    static func facePixels(for shape: FaceShape, gridSize _: Int) -> [(x: Int, y: Int)] {
        switch shape {
        case .oval: return ovalFacePixels
        case .round: return roundFacePixels
        case .square: return squareFacePixels
        case .heart: return heartFacePixels
        case .oblong: return oblongFacePixels
        case .diamond: return diamondFacePixels
        }
    }

    // Oval face - slightly taller than wide
    private static let ovalFacePixels: [(x: Int, y: Int)] = {
        var pixels: [(x: Int, y: Int)] = []
        // Build oval row by row (y from 5 to 27)
        let rows: [(y: Int, xStart: Int, xEnd: Int)] = [
            (5, 12, 19), (6, 10, 21), (7, 9, 22), (8, 8, 23),
            (9, 7, 24), (10, 6, 25), (11, 6, 25), (12, 5, 26),
            (13, 5, 26), (14, 5, 26), (15, 5, 26), (16, 5, 26),
            (17, 5, 26), (18, 5, 26), (19, 6, 25), (20, 6, 25),
            (21, 7, 24), (22, 7, 24), (23, 8, 23), (24, 9, 22),
            (25, 10, 21), (26, 12, 19),
        ]
        for row in rows {
            for x in row.xStart ... row.xEnd {
                pixels.append((x, row.y))
            }
        }
        return pixels
    }()

    // Round face - circular
    private static let roundFacePixels: [(x: Int, y: Int)] = {
        var pixels: [(x: Int, y: Int)] = []
        let rows: [(y: Int, xStart: Int, xEnd: Int)] = [
            (5, 11, 20), (6, 9, 22), (7, 8, 23), (8, 7, 24),
            (9, 6, 25), (10, 5, 26), (11, 5, 26), (12, 5, 26),
            (13, 4, 27), (14, 4, 27), (15, 4, 27), (16, 4, 27),
            (17, 4, 27), (18, 4, 27), (19, 5, 26), (20, 5, 26),
            (21, 5, 26), (22, 6, 25), (23, 7, 24), (24, 8, 23),
            (25, 9, 22), (26, 11, 20),
        ]
        for row in rows {
            for x in row.xStart ... row.xEnd {
                pixels.append((x, row.y))
            }
        }
        return pixels
    }()

    // Square face - rounded rectangle
    private static let squareFacePixels: [(x: Int, y: Int)] = {
        var pixels: [(x: Int, y: Int)] = []
        let rows: [(y: Int, xStart: Int, xEnd: Int)] = [
            (5, 10, 21), (6, 8, 23), (7, 7, 24), (8, 6, 25),
            (9, 6, 25), (10, 6, 25), (11, 6, 25), (12, 6, 25),
            (13, 6, 25), (14, 6, 25), (15, 6, 25), (16, 6, 25),
            (17, 6, 25), (18, 6, 25), (19, 6, 25), (20, 6, 25),
            (21, 6, 25), (22, 6, 25), (23, 7, 24), (24, 8, 23),
            (25, 10, 21),
        ]
        for row in rows {
            for x in row.xStart ... row.xEnd {
                pixels.append((x, row.y))
            }
        }
        return pixels
    }()

    // Heart face - wider at top, pointed chin
    private static let heartFacePixels: [(x: Int, y: Int)] = {
        var pixels: [(x: Int, y: Int)] = []
        let rows: [(y: Int, xStart: Int, xEnd: Int)] = [
            (5, 9, 22), (6, 7, 24), (7, 6, 25), (8, 5, 26),
            (9, 5, 26), (10, 5, 26), (11, 5, 26), (12, 6, 25),
            (13, 6, 25), (14, 7, 24), (15, 7, 24), (16, 8, 23),
            (17, 8, 23), (18, 9, 22), (19, 9, 22), (20, 10, 21),
            (21, 11, 20), (22, 12, 19), (23, 13, 18), (24, 14, 17),
            (25, 15, 16),
        ]
        for row in rows {
            for x in row.xStart ... row.xEnd {
                pixels.append((x, row.y))
            }
        }
        return pixels
    }()

    // Oblong face - taller and narrower
    private static let oblongFacePixels: [(x: Int, y: Int)] = {
        var pixels: [(x: Int, y: Int)] = []
        let rows: [(y: Int, xStart: Int, xEnd: Int)] = [
            (4, 12, 19), (5, 10, 21), (6, 9, 22), (7, 8, 23),
            (8, 7, 24), (9, 7, 24), (10, 7, 24), (11, 7, 24),
            (12, 7, 24), (13, 7, 24), (14, 7, 24), (15, 7, 24),
            (16, 7, 24), (17, 7, 24), (18, 7, 24), (19, 7, 24),
            (20, 7, 24), (21, 7, 24), (22, 8, 23), (23, 9, 22),
            (24, 10, 21), (25, 11, 20), (26, 12, 19), (27, 13, 18),
        ]
        for row in rows {
            for x in row.xStart ... row.xEnd {
                pixels.append((x, row.y))
            }
        }
        return pixels
    }()

    // Diamond face - widest at cheeks
    private static let diamondFacePixels: [(x: Int, y: Int)] = {
        var pixels: [(x: Int, y: Int)] = []
        let rows: [(y: Int, xStart: Int, xEnd: Int)] = [
            (5, 14, 17), (6, 13, 18), (7, 12, 19), (8, 11, 20),
            (9, 10, 21), (10, 9, 22), (11, 8, 23), (12, 7, 24),
            (13, 6, 25), (14, 5, 26), (15, 5, 26), (16, 5, 26),
            (17, 6, 25), (18, 7, 24), (19, 8, 23), (20, 9, 22),
            (21, 10, 21), (22, 11, 20), (23, 12, 19), (24, 13, 18),
            (25, 14, 17), (26, 15, 16),
        ]
        for row in rows {
            for x in row.xStart ... row.xEnd {
                pixels.append((x, row.y))
            }
        }
        return pixels
    }()

    // MARK: - Eyes

    /// Returns eye pixels with colors for left and right eyes.
    static func eyePixels(
        for style: Eyes,
        eyeColor: CGColor,
        gridSize _: Int
    ) -> (left: [(pixels: [(x: Int, y: Int)], color: CGColor)],
          right: [(pixels: [(x: Int, y: Int)], color: CGColor)])
    {
        let white = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        let black = CGColor(red: 0, green: 0, blue: 0, alpha: 1)

        // Eye positions: left eye center ~x=11, right eye center ~x=20, y=13
        let leftX = 10
        let rightX = 19
        let eyeY = 13

        switch style {
        case .round, .wide:
            // 3x2 white, 1x1 iris, 1x1 pupil
            let leftWhite = [(leftX, eyeY), (leftX + 1, eyeY), (leftX + 2, eyeY),
                             (leftX, eyeY + 1), (leftX + 1, eyeY + 1), (leftX + 2, eyeY + 1)]
            let leftIris = [(leftX + 1, eyeY)]
            let leftPupil = [(leftX + 1, eyeY + 1)]

            let rightWhite = [(rightX, eyeY), (rightX + 1, eyeY), (rightX + 2, eyeY),
                              (rightX, eyeY + 1), (rightX + 1, eyeY + 1), (rightX + 2, eyeY + 1)]
            let rightIris = [(rightX + 1, eyeY)]
            let rightPupil = [(rightX + 1, eyeY + 1)]

            return (
                left: [(leftWhite, white), (leftIris, eyeColor), (leftPupil, black)],
                right: [(rightWhite, white), (rightIris, eyeColor), (rightPupil, black)]
            )

        case .almond:
            // Almond shape - pointed at corners
            let leftWhite = [(leftX, eyeY), (leftX + 1, eyeY), (leftX + 2, eyeY), (leftX + 3, eyeY),
                             (leftX + 1, eyeY + 1), (leftX + 2, eyeY + 1)]
            let leftIris = [(leftX + 1, eyeY), (leftX + 2, eyeY)]
            let leftPupil = [(leftX + 2, eyeY)]

            let rightWhite = [(rightX - 1, eyeY), (rightX, eyeY), (rightX + 1, eyeY), (rightX + 2, eyeY),
                              (rightX, eyeY + 1), (rightX + 1, eyeY + 1)]
            let rightIris = [(rightX, eyeY), (rightX + 1, eyeY)]
            let rightPupil = [(rightX, eyeY)]

            return (
                left: [(leftWhite, white), (leftIris, eyeColor), (leftPupil, black)],
                right: [(rightWhite, white), (rightIris, eyeColor), (rightPupil, black)]
            )

        case .hooded:
            // Hooded - slightly covered on top
            let leftWhite = [(leftX, eyeY + 1), (leftX + 1, eyeY + 1), (leftX + 2, eyeY + 1),
                             (leftX + 1, eyeY)]
            let leftIris = [(leftX + 1, eyeY + 1)]
            let leftPupil = [(leftX + 1, eyeY)]

            let rightWhite = [(rightX, eyeY + 1), (rightX + 1, eyeY + 1), (rightX + 2, eyeY + 1),
                              (rightX + 1, eyeY)]
            let rightIris = [(rightX + 1, eyeY + 1)]
            let rightPupil = [(rightX + 1, eyeY)]

            return (
                left: [(leftWhite, white), (leftIris, eyeColor), (leftPupil, black)],
                right: [(rightWhite, white), (rightIris, eyeColor), (rightPupil, black)]
            )

        case .upturned:
            // Upturned - outer corner higher
            let leftWhite = [(leftX, eyeY + 1), (leftX + 1, eyeY), (leftX + 2, eyeY),
                             (leftX + 1, eyeY + 1), (leftX + 2, eyeY + 1)]
            let leftIris = [(leftX + 1, eyeY)]
            let leftPupil = [(leftX + 1, eyeY + 1)]

            let rightWhite = [(rightX, eyeY), (rightX + 1, eyeY), (rightX + 2, eyeY + 1),
                              (rightX, eyeY + 1), (rightX + 1, eyeY + 1)]
            let rightIris = [(rightX + 1, eyeY)]
            let rightPupil = [(rightX + 1, eyeY + 1)]

            return (
                left: [(leftWhite, white), (leftIris, eyeColor), (leftPupil, black)],
                right: [(rightWhite, white), (rightIris, eyeColor), (rightPupil, black)]
            )

        case .downturned:
            // Downturned - outer corner lower
            let leftWhite = [(leftX, eyeY), (leftX + 1, eyeY), (leftX + 2, eyeY + 1),
                             (leftX, eyeY + 1), (leftX + 1, eyeY + 1)]
            let leftIris = [(leftX + 1, eyeY)]
            let leftPupil = [(leftX + 1, eyeY + 1)]

            let rightWhite = [(rightX, eyeY + 1), (rightX + 1, eyeY), (rightX + 2, eyeY),
                              (rightX + 1, eyeY + 1), (rightX + 2, eyeY + 1)]
            let rightIris = [(rightX + 1, eyeY)]
            let rightPupil = [(rightX + 1, eyeY + 1)]

            return (
                left: [(leftWhite, white), (leftIris, eyeColor), (leftPupil, black)],
                right: [(rightWhite, white), (rightIris, eyeColor), (rightPupil, black)]
            )

        case .narrow:
            // Narrow - single row
            let leftWhite = [(leftX, eyeY), (leftX + 1, eyeY), (leftX + 2, eyeY)]
            let leftIris = [(leftX + 1, eyeY)]
            let leftPupil: [(x: Int, y: Int)] = []

            let rightWhite = [(rightX, eyeY), (rightX + 1, eyeY), (rightX + 2, eyeY)]
            let rightIris = [(rightX + 1, eyeY)]
            let rightPupil: [(x: Int, y: Int)] = []

            return (
                left: [(leftWhite, white), (leftIris, eyeColor), (leftPupil, black)],
                right: [(rightWhite, white), (rightIris, eyeColor), (rightPupil, black)]
            )

        case .wink:
            // Left eye winking (horizontal line), right eye normal
            let leftWink = [(leftX, eyeY), (leftX + 1, eyeY), (leftX + 2, eyeY)]

            let rightWhite = [(rightX, eyeY), (rightX + 1, eyeY), (rightX + 2, eyeY),
                              (rightX, eyeY + 1), (rightX + 1, eyeY + 1), (rightX + 2, eyeY + 1)]
            let rightIris = [(rightX + 1, eyeY)]
            let rightPupil = [(rightX + 1, eyeY + 1)]

            return (
                left: [(leftWink, black)],
                right: [(rightWhite, white), (rightIris, eyeColor), (rightPupil, black)]
            )
        }
    }

    // MARK: - Eyebrows

    /// Returns eyebrow pixels for both left and right eyebrows.
    static func eyebrowPixels(for style: Eyebrows, gridSize _: Int) -> [(x: Int, y: Int)] {
        let leftX = 9
        let rightX = 19
        let browY = 10

        switch style {
        case .natural:
            // Gentle curve
            return [
                // Left
                (leftX, browY), (leftX + 1, browY), (leftX + 2, browY), (leftX + 3, browY),
                (leftX + 1, browY - 1),
                // Right
                (rightX, browY), (rightX + 1, browY), (rightX + 2, browY), (rightX + 3, browY),
                (rightX + 2, browY - 1),
            ]

        case .arched:
            // Higher arch
            return [
                // Left
                (leftX, browY + 1), (leftX + 1, browY), (leftX + 2, browY - 1), (leftX + 3, browY),
                // Right
                (rightX, browY), (rightX + 1, browY - 1), (rightX + 2, browY), (rightX + 3, browY + 1),
            ]

        case .straight:
            // Horizontal line
            return [
                // Left
                (leftX, browY), (leftX + 1, browY), (leftX + 2, browY), (leftX + 3, browY),
                // Right
                (rightX, browY), (rightX + 1, browY), (rightX + 2, browY), (rightX + 3, browY),
            ]

        case .thick:
            // Two rows
            return [
                // Left
                (leftX, browY), (leftX + 1, browY), (leftX + 2, browY), (leftX + 3, browY),
                (leftX, browY + 1), (leftX + 1, browY + 1), (leftX + 2, browY + 1), (leftX + 3, browY + 1),
                // Right
                (rightX, browY), (rightX + 1, browY), (rightX + 2, browY), (rightX + 3, browY),
                (rightX, browY + 1), (rightX + 1, browY + 1), (rightX + 2, browY + 1), (rightX + 3, browY + 1),
            ]

        case .thin:
            // Single thin line
            return [
                // Left
                (leftX, browY), (leftX + 1, browY), (leftX + 2, browY),
                // Right
                (rightX + 1, browY), (rightX + 2, browY), (rightX + 3, browY),
            ]

        case .raised:
            // Positioned higher
            let raisedY = browY - 2
            return [
                // Left
                (leftX, raisedY), (leftX + 1, raisedY), (leftX + 2, raisedY), (leftX + 3, raisedY),
                // Right
                (rightX, raisedY), (rightX + 1, raisedY), (rightX + 2, raisedY), (rightX + 3, raisedY),
            ]
        }
    }

    // MARK: - Nose

    /// Returns nose pixels.
    static func nosePixels(for style: Nose, gridSize _: Int) -> [(x: Int, y: Int)] {
        let centerX = 15
        let noseY = 17

        switch style {
        case .small:
            return [(centerX, noseY), (centerX + 1, noseY)]

        case .medium:
            return [
                (centerX, noseY - 1), (centerX + 1, noseY - 1),
                (centerX, noseY), (centerX + 1, noseY),
            ]

        case .large:
            return [
                (centerX, noseY - 2), (centerX + 1, noseY - 2),
                (centerX - 1, noseY - 1), (centerX, noseY - 1), (centerX + 1, noseY - 1), (centerX + 2, noseY - 1),
                (centerX - 1, noseY), (centerX, noseY), (centerX + 1, noseY), (centerX + 2, noseY),
            ]

        case .pointed:
            return [
                (centerX, noseY - 2), (centerX + 1, noseY - 2),
                (centerX, noseY - 1), (centerX + 1, noseY - 1),
                (centerX, noseY),
            ]

        case .rounded:
            return [
                (centerX, noseY - 1), (centerX + 1, noseY - 1),
                (centerX - 1, noseY), (centerX, noseY), (centerX + 1, noseY), (centerX + 2, noseY),
            ]

        case .button:
            return [(centerX, noseY), (centerX + 1, noseY)]
        }
    }

    // MARK: - Mouth

    /// Returns mouth pixels.
    static func mouthPixels(for style: Mouth, gridSize _: Int) -> [(x: Int, y: Int)] {
        let centerX = 13
        let mouthY = 22

        switch style {
        case .smile:
            // Upward curve
            return [
                (centerX, mouthY), (centerX + 1, mouthY), (centerX + 2, mouthY), (centerX + 3, mouthY), (centerX + 4, mouthY), (centerX + 5, mouthY),
                (centerX + 1, mouthY + 1), (centerX + 2, mouthY + 1), (centerX + 3, mouthY + 1), (centerX + 4, mouthY + 1),
            ]

        case .neutral:
            // Straight line
            return [
                (centerX + 1, mouthY), (centerX + 2, mouthY), (centerX + 3, mouthY), (centerX + 4, mouthY),
            ]

        case .slight:
            // Slight smile
            return [
                (centerX + 1, mouthY), (centerX + 2, mouthY), (centerX + 3, mouthY), (centerX + 4, mouthY),
                (centerX + 2, mouthY + 1), (centerX + 3, mouthY + 1),
            ]

        case .grin:
            // Big smile with teeth hint
            return [
                (centerX, mouthY), (centerX + 1, mouthY), (centerX + 2, mouthY), (centerX + 3, mouthY), (centerX + 4, mouthY), (centerX + 5, mouthY),
                (centerX, mouthY + 1), (centerX + 1, mouthY + 1), (centerX + 2, mouthY + 1), (centerX + 3, mouthY + 1), (centerX + 4, mouthY + 1), (centerX + 5, mouthY + 1),
            ]

        case .pout:
            // Small pursed
            return [
                (centerX + 2, mouthY), (centerX + 3, mouthY),
                (centerX + 1, mouthY + 1), (centerX + 2, mouthY + 1), (centerX + 3, mouthY + 1), (centerX + 4, mouthY + 1),
                (centerX + 2, mouthY + 2), (centerX + 3, mouthY + 2),
            ]

        case .open:
            // Open mouth (surprised)
            return [
                (centerX + 1, mouthY), (centerX + 2, mouthY), (centerX + 3, mouthY), (centerX + 4, mouthY),
                (centerX, mouthY + 1), (centerX + 1, mouthY + 1), (centerX + 2, mouthY + 1), (centerX + 3, mouthY + 1), (centerX + 4, mouthY + 1), (centerX + 5, mouthY + 1),
                (centerX + 1, mouthY + 2), (centerX + 2, mouthY + 2), (centerX + 3, mouthY + 2), (centerX + 4, mouthY + 2),
            ]

        case .smirk:
            // Asymmetric
            return [
                (centerX + 1, mouthY), (centerX + 2, mouthY), (centerX + 3, mouthY), (centerX + 4, mouthY),
                (centerX + 3, mouthY + 1), (centerX + 4, mouthY + 1),
            ]

        case .serious:
            // Flat with slight downturn
            return [
                (centerX + 1, mouthY), (centerX + 2, mouthY), (centerX + 3, mouthY), (centerX + 4, mouthY),
                (centerX, mouthY + 1), (centerX + 5, mouthY + 1),
            ]
        }
    }

    // MARK: - Hair Back

    /// Returns back hair pixels (rendered behind face).
    static func hairBackPixels(for style: HairStyle, gridSize _: Int) -> [(x: Int, y: Int)] {
        switch style {
        case .bald:
            return []

        case .short, .buzz:
            // Minimal back hair
            return []

        case .medium, .wavy:
            // Slight back coverage
            var pixels: [(x: Int, y: Int)] = []
            for x in 6 ... 25 {
                pixels.append((x, 4))
                pixels.append((x, 5))
            }
            return pixels

        case .long:
            // Long hair down sides
            var pixels: [(x: Int, y: Int)] = []
            // Top back
            for y in 3 ... 6 {
                for x in 5 ... 26 {
                    pixels.append((x, y))
                }
            }
            // Side strands
            for y in 7 ... 26 {
                for x in 3 ... 6 {
                    pixels.append((x, y))
                }
                for x in 25 ... 28 {
                    pixels.append((x, y))
                }
            }
            return pixels

        case .curly:
            // Curly puffs around head
            var pixels: [(x: Int, y: Int)] = []
            for y in 2 ... 7 {
                for x in 4 ... 27 {
                    pixels.append((x, y))
                }
            }
            // Side puffs
            for y in 8 ... 16 {
                for x in 2 ... 5 {
                    pixels.append((x, y))
                }
                for x in 26 ... 29 {
                    pixels.append((x, y))
                }
            }
            return pixels

        case .spiky:
            return []

        case .mohawk:
            return []

        case .ponytail:
            // Ponytail at back
            var pixels: [(x: Int, y: Int)] = []
            for y in 3 ... 6 {
                for x in 8 ... 23 {
                    pixels.append((x, y))
                }
            }
            // Ponytail tail
            for y in 0 ... 4 {
                for x in 13 ... 18 {
                    pixels.append((x, y))
                }
            }
            return pixels

        case .bun:
            // Bun at top back
            var pixels: [(x: Int, y: Int)] = []
            for y in 4 ... 7 {
                for x in 8 ... 23 {
                    pixels.append((x, y))
                }
            }
            return pixels

        case .afro:
            // Large afro back
            var pixels: [(x: Int, y: Int)] = []
            for y in 0 ... 8 {
                for x in 2 ... 29 {
                    pixels.append((x, y))
                }
            }
            for y in 9 ... 20 {
                for x in 0 ... 4 {
                    pixels.append((x, y))
                }
                for x in 27 ... 31 {
                    pixels.append((x, y))
                }
            }
            return pixels
        }
    }

    // MARK: - Hair Front

    /// Returns front hair pixels (rendered in front of face).
    static func hairFrontPixels(for style: HairStyle, gridSize _: Int) -> [(x: Int, y: Int)] {
        switch style {
        case .bald:
            return []

        case .short:
            // Short cropped hair
            var pixels: [(x: Int, y: Int)] = []
            let rows: [(y: Int, xStart: Int, xEnd: Int)] = [
                (3, 11, 20), (4, 9, 22), (5, 8, 23), (6, 7, 10), (6, 21, 24),
            ]
            for row in rows {
                for x in row.xStart ... row.xEnd {
                    pixels.append((x, row.y))
                }
            }
            return pixels

        case .medium:
            // Medium length with some fringe
            var pixels: [(x: Int, y: Int)] = []
            let rows: [(y: Int, xStart: Int, xEnd: Int)] = [
                (2, 12, 19), (3, 10, 21), (4, 8, 23), (5, 7, 24),
                (6, 6, 9), (6, 22, 25), (7, 5, 8), (7, 23, 26),
            ]
            for row in rows {
                for x in row.xStart ... row.xEnd {
                    pixels.append((x, row.y))
                }
            }
            return pixels

        case .long:
            // Long flowing hair
            var pixels: [(x: Int, y: Int)] = []
            let rows: [(y: Int, xStart: Int, xEnd: Int)] = [
                (2, 11, 20), (3, 9, 22), (4, 7, 24), (5, 6, 25),
                (6, 5, 8), (6, 23, 26), (7, 4, 7), (7, 24, 27),
                (8, 3, 6), (8, 25, 28),
            ]
            for row in rows {
                for x in row.xStart ... row.xEnd {
                    pixels.append((x, row.y))
                }
            }
            return pixels

        case .curly:
            // Curly top
            var pixels: [(x: Int, y: Int)] = []
            let rows: [(y: Int, xStart: Int, xEnd: Int)] = [
                (1, 10, 12), (1, 14, 17), (1, 19, 21),
                (2, 8, 23), (3, 7, 24), (4, 6, 25),
                (5, 5, 8), (5, 12, 14), (5, 17, 19), (5, 23, 26),
            ]
            for row in rows {
                for x in row.xStart ... row.xEnd {
                    pixels.append((x, row.y))
                }
            }
            return pixels

        case .wavy:
            // Wavy pattern
            var pixels: [(x: Int, y: Int)] = []
            let rows: [(y: Int, xStart: Int, xEnd: Int)] = [
                (2, 10, 13), (2, 16, 21),
                (3, 8, 14), (3, 17, 23),
                (4, 7, 12), (4, 14, 16), (4, 19, 24),
                (5, 6, 10), (5, 21, 25),
                (6, 5, 8), (6, 23, 26),
            ]
            for row in rows {
                for x in row.xStart ... row.xEnd {
                    pixels.append((x, row.y))
                }
            }
            return pixels

        case .spiky:
            // Spiky upward points
            var pixels: [(x: Int, y: Int)] = []
            // Spikes
            let spikes = [
                [(9, 5), (10, 4), (10, 3), (11, 2)],
                [(13, 5), (13, 4), (14, 3), (14, 2), (15, 1)],
                [(17, 5), (17, 4), (18, 3), (18, 2), (19, 1)],
                [(21, 5), (21, 4), (22, 3), (22, 2)],
            ]
            for spike in spikes {
                pixels.append(contentsOf: spike)
            }
            // Base
            for x in 8 ... 23 {
                pixels.append((x, 6))
            }
            return pixels

        case .buzz:
            // Very short buzz cut
            var pixels: [(x: Int, y: Int)] = []
            let rows: [(y: Int, xStart: Int, xEnd: Int)] = [
                (4, 10, 21), (5, 8, 23), (6, 7, 8), (6, 23, 24),
            ]
            for row in rows {
                for x in row.xStart ... row.xEnd {
                    pixels.append((x, row.y))
                }
            }
            return pixels

        case .mohawk:
            // Central mohawk spike
            var pixels: [(x: Int, y: Int)] = []
            for y in 0 ... 6 {
                let width = min(y + 1, 4)
                let startX = 15 - width / 2
                for x in startX ... (startX + width) {
                    pixels.append((x, y))
                }
            }
            return pixels

        case .ponytail:
            // Front with pulled back look
            var pixels: [(x: Int, y: Int)] = []
            let rows: [(y: Int, xStart: Int, xEnd: Int)] = [
                (3, 11, 20), (4, 9, 22), (5, 8, 9), (5, 22, 23),
            ]
            for row in rows {
                for x in row.xStart ... row.xEnd {
                    pixels.append((x, row.y))
                }
            }
            return pixels

        case .bun:
            // Bun on top
            var pixels: [(x: Int, y: Int)] = []
            // Bun circle
            for y in 0 ... 3 {
                let offset = y == 0 || y == 3 ? 1 : 0
                for x in (13 + offset) ... (18 - offset) {
                    pixels.append((x, y))
                }
            }
            // Front hair
            for x in 9 ... 22 {
                pixels.append((x, 5))
            }
            return pixels

        case .afro:
            // Large afro
            var pixels: [(x: Int, y: Int)] = []
            let rows: [(y: Int, xStart: Int, xEnd: Int)] = [
                (0, 10, 21), (1, 7, 24), (2, 5, 26), (3, 4, 27),
                (4, 3, 28), (5, 2, 6), (5, 25, 29),
                (6, 2, 5), (6, 26, 29), (7, 1, 4), (7, 27, 30),
            ]
            for row in rows {
                for x in row.xStart ... row.xEnd {
                    pixels.append((x, row.y))
                }
            }
            return pixels
        }
    }

    // MARK: - Accessories: Glasses

    /// Returns glasses frame pixels.
    static func glassesPixels(for style: Accessories.Glasses, gridSize _: Int) -> [(x: Int, y: Int)] {
        let leftX = 8
        let rightX = 18
        let glassY = 12

        switch style {
        case .round:
            // Round frames
            var pixels: [(x: Int, y: Int)] = []
            // Left lens frame
            pixels.append(contentsOf: [(leftX, glassY), (leftX + 1, glassY - 1), (leftX + 2, glassY - 1), (leftX + 3, glassY - 1), (leftX + 4, glassY)])
            pixels.append(contentsOf: [(leftX, glassY + 1), (leftX, glassY + 2), (leftX + 4, glassY + 1), (leftX + 4, glassY + 2)])
            pixels.append(contentsOf: [(leftX, glassY + 3), (leftX + 1, glassY + 3), (leftX + 2, glassY + 3), (leftX + 3, glassY + 3), (leftX + 4, glassY + 3)])
            // Right lens frame
            pixels.append(contentsOf: [(rightX, glassY), (rightX + 1, glassY - 1), (rightX + 2, glassY - 1), (rightX + 3, glassY - 1), (rightX + 4, glassY)])
            pixels.append(contentsOf: [(rightX, glassY + 1), (rightX, glassY + 2), (rightX + 4, glassY + 1), (rightX + 4, glassY + 2)])
            pixels.append(contentsOf: [(rightX, glassY + 3), (rightX + 1, glassY + 3), (rightX + 2, glassY + 3), (rightX + 3, glassY + 3), (rightX + 4, glassY + 3)])
            // Bridge
            pixels.append(contentsOf: [(leftX + 5, glassY + 1), (leftX + 6, glassY + 1), (rightX - 1, glassY + 1)])
            return pixels

        case .rectangular:
            // Rectangular frames
            var pixels: [(x: Int, y: Int)] = []
            // Left
            for x in leftX ... (leftX + 4) {
                pixels.append((x, glassY))
                pixels.append((x, glassY + 2))
            }
            pixels.append((leftX, glassY + 1))
            pixels.append((leftX + 4, glassY + 1))
            // Right
            for x in rightX ... (rightX + 4) {
                pixels.append((x, glassY))
                pixels.append((x, glassY + 2))
            }
            pixels.append((rightX, glassY + 1))
            pixels.append((rightX + 4, glassY + 1))
            // Bridge
            pixels.append(contentsOf: [(leftX + 5, glassY + 1), (rightX - 1, glassY + 1)])
            return pixels

        case .aviator:
            // Aviator style (larger)
            var pixels: [(x: Int, y: Int)] = []
            let leftStart = leftX - 1
            let rightStart = rightX - 1
            // Left
            for x in leftStart ... (leftStart + 6) {
                pixels.append((x, glassY - 1))
                pixels.append((x, glassY + 3))
            }
            for y in glassY ... (glassY + 2) {
                pixels.append((leftStart, y))
                pixels.append((leftStart + 6, y))
            }
            // Right
            for x in rightStart ... (rightStart + 6) {
                pixels.append((x, glassY - 1))
                pixels.append((x, glassY + 3))
            }
            for y in glassY ... (glassY + 2) {
                pixels.append((rightStart, y))
                pixels.append((rightStart + 6, y))
            }
            // Bridge
            pixels.append((15, glassY))
            pixels.append((16, glassY))
            return pixels

        case .catEye:
            // Cat eye (pointed at top corners)
            var pixels: [(x: Int, y: Int)] = []
            // Left - pointed top outer
            pixels.append(contentsOf: [(leftX, glassY + 1), (leftX + 1, glassY), (leftX + 2, glassY - 1)])
            pixels.append(contentsOf: [(leftX + 3, glassY), (leftX + 4, glassY + 1)])
            for y in (glassY + 1) ... (glassY + 2) {
                pixels.append((leftX, y))
                pixels.append((leftX + 4, y))
            }
            pixels.append(contentsOf: [(leftX + 1, glassY + 3), (leftX + 2, glassY + 3), (leftX + 3, glassY + 3)])
            // Right - pointed top outer (mirrored)
            pixels.append(contentsOf: [(rightX, glassY + 1), (rightX + 1, glassY), (rightX + 2, glassY - 1)])
            pixels.append(contentsOf: [(rightX + 3, glassY), (rightX + 4, glassY + 1)])
            for y in (glassY + 1) ... (glassY + 2) {
                pixels.append((rightX, y))
                pixels.append((rightX + 4, y))
            }
            pixels.append(contentsOf: [(rightX + 1, glassY + 3), (rightX + 2, glassY + 3), (rightX + 3, glassY + 3)])
            // Bridge
            pixels.append(contentsOf: [(leftX + 5, glassY + 1), (rightX - 1, glassY + 1)])
            return pixels

        case .rimless:
            // Just bridge, no frames
            return [(14, glassY + 1), (15, glassY + 1), (16, glassY + 1), (17, glassY + 1)]
        }
    }

    /// Returns lens pixels (for tinting).
    static func lensPixels(for style: Accessories.Glasses, gridSize _: Int) -> [(x: Int, y: Int)] {
        let leftX = 8
        let rightX = 18
        let glassY = 12

        switch style {
        case .round, .catEye:
            var pixels: [(x: Int, y: Int)] = []
            // Left lens interior
            for y in glassY ... (glassY + 2) {
                for x in (leftX + 1) ... (leftX + 3) {
                    pixels.append((x, y))
                }
            }
            // Right lens interior
            for y in glassY ... (glassY + 2) {
                for x in (rightX + 1) ... (rightX + 3) {
                    pixels.append((x, y))
                }
            }
            return pixels

        case .rectangular:
            var pixels: [(x: Int, y: Int)] = []
            // Left
            for x in (leftX + 1) ... (leftX + 3) {
                pixels.append((x, glassY + 1))
            }
            // Right
            for x in (rightX + 1) ... (rightX + 3) {
                pixels.append((x, glassY + 1))
            }
            return pixels

        case .aviator:
            var pixels: [(x: Int, y: Int)] = []
            let leftStart = leftX - 1
            let rightStart = rightX - 1
            for y in glassY ... (glassY + 2) {
                for x in (leftStart + 1) ... (leftStart + 5) {
                    pixels.append((x, y))
                }
                for x in (rightStart + 1) ... (rightStart + 5) {
                    pixels.append((x, y))
                }
            }
            return pixels

        case .rimless:
            return []
        }
    }

    // MARK: - Accessories: Facial Hair

    /// Returns facial hair pixels.
    static func facialHairPixels(for style: Accessories.FacialHair, gridSize _: Int) -> [(x: Int, y: Int)] {
        switch style {
        case .stubble:
            // Scattered dots
            return [
                (11, 21), (13, 20), (15, 21), (17, 20), (19, 21),
                (10, 23), (12, 22), (14, 23), (16, 22), (18, 23), (20, 22),
                (11, 25), (14, 24), (17, 25), (19, 24),
            ]

        case .goatee:
            // Chin goatee
            var pixels: [(x: Int, y: Int)] = []
            for y in 24 ... 27 {
                let width = y == 24 || y == 27 ? 2 : 4
                let startX = 15 - width / 2
                for x in startX ... (startX + width) {
                    pixels.append((x, y))
                }
            }
            return pixels

        case .fullBeard:
            // Full beard covering lower face
            var pixels: [(x: Int, y: Int)] = []
            let rows: [(y: Int, xStart: Int, xEnd: Int)] = [
                (20, 8, 10), (20, 21, 23),
                (21, 7, 11), (21, 20, 24),
                (22, 6, 25), (23, 7, 24), (24, 8, 23),
                (25, 9, 22), (26, 10, 21), (27, 12, 19),
            ]
            for row in rows {
                for x in row.xStart ... row.xEnd {
                    pixels.append((x, row.y))
                }
            }
            return pixels

        case .mustache:
            // Mustache above lips
            return [
                (10, 20), (11, 19), (12, 19), (13, 19), (14, 20),
                (17, 20), (18, 19), (19, 19), (20, 19), (21, 20),
            ]

        case .soulPatch:
            // Small patch below lips
            return [(15, 24), (16, 24), (15, 25), (16, 25)]
        }
    }

    // MARK: - Accessories: Earrings

    /// Returns earring pixels.
    static func earringPixels(for style: Accessories.Earrings, gridSize _: Int) -> [(x: Int, y: Int)] {
        switch style {
        case .studs:
            // Small studs on ears
            return [(3, 15), (28, 15)]

        case .hoops:
            // Hoop earrings
            return [
                (2, 15), (3, 16), (3, 17), (2, 18),
                (29, 15), (28, 16), (28, 17), (29, 18),
            ]

        case .dangles:
            // Dangling earrings
            return [
                (3, 15), (3, 16), (3, 17), (3, 18), (3, 19),
                (28, 15), (28, 16), (28, 17), (28, 18), (28, 19),
            ]
        }
    }
}
