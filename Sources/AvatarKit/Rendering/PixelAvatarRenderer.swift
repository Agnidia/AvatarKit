import CoreGraphics
import SwiftUI

/// Renders pixel art avatars at native 32x32 resolution.
///
/// This renderer creates a CGImage at the specified grid size (default 32x32)
/// with anti-aliasing disabled for crisp pixel art. The resulting image can
/// be scaled up with `.interpolation(.none)` to preserve the chunky pixel aesthetic.
struct PixelAvatarRenderer: Sendable {
    /// The pixel grid size (width and height).
    let gridSize: Int

    /// Create a pixel avatar renderer.
    /// - Parameter gridSize: The pixel grid size (default: 32).
    init(gridSize: Int = 32) {
        self.gridSize = gridSize
    }

    /// Render face data to a CGImage at native pixel resolution.
    /// - Parameter faceData: The face data to render.
    /// - Returns: A CGImage at the native grid size, or nil if rendering fails.
    func render(_ faceData: FaceData) -> CGImage? {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)

        guard let context = CGContext(
            data: nil,
            width: gridSize,
            height: gridSize,
            bitsPerComponent: 8,
            bytesPerRow: gridSize * 4,
            space: colorSpace,
            bitmapInfo: bitmapInfo.rawValue
        ) else { return nil }

        // CRITICAL: Disable anti-aliasing for crisp pixels
        context.setShouldAntialias(false)
        context.interpolationQuality = .none

        // Flip coordinate system (CGContext has origin at bottom-left)
        context.translateBy(x: 0, y: CGFloat(gridSize))
        context.scaleBy(x: 1, y: -1)

        // Render layers in order (back to front)
        renderFace(faceData, in: context)
        renderHairBack(faceData, in: context)
        renderEars(faceData, in: context)
        renderEyebrows(faceData, in: context)
        renderEyes(faceData, in: context)
        renderNose(faceData, in: context)
        renderMouth(faceData, in: context)
        renderHairFront(faceData, in: context)
        renderAccessories(faceData, in: context)

        return context.makeImage()
    }

    // MARK: - Pixel Drawing Primitives

    /// Fill pixels at the given coordinates with a color.
    private func fillPixels(_ pixels: [(x: Int, y: Int)], color: CGColor, in context: CGContext) {
        context.setFillColor(color)
        for pixel in pixels {
            guard pixel.x >= 0, pixel.x < gridSize, pixel.y >= 0, pixel.y < gridSize else { continue }
            context.fill(CGRect(x: pixel.x, y: pixel.y, width: 1, height: 1))
        }
    }

    /// Fill a rectangle of pixels.
    private func fillRect(x: Int, y: Int, width: Int, height: Int, color: CGColor, in context: CGContext) {
        context.setFillColor(color)
        context.fill(CGRect(x: x, y: y, width: width, height: height))
    }

    /// Generate pixels for a filled circle using midpoint algorithm.
    private func circlePixels(centerX: Int, centerY: Int, radius: Int) -> [(x: Int, y: Int)] {
        var pixels: [(x: Int, y: Int)] = []
        let radiusSq = radius * radius
        for dy in -radius ... radius {
            for dx in -radius ... radius {
                if dx * dx + dy * dy <= radiusSq {
                    pixels.append((centerX + dx, centerY + dy))
                }
            }
        }
        return pixels
    }

    /// Generate pixels for a filled ellipse.
    private func ellipsePixels(centerX: Int, centerY: Int, radiusX: Int, radiusY: Int) -> [(x: Int, y: Int)] {
        var pixels: [(x: Int, y: Int)] = []
        let rxSq = radiusX * radiusX
        let rySq = radiusY * radiusY
        for dy in -radiusY ... radiusY {
            for dx in -radiusX ... radiusX {
                let check = (dx * dx * rySq) + (dy * dy * rxSq)
                if check <= rxSq * rySq {
                    pixels.append((centerX + dx, centerY + dy))
                }
            }
        }
        return pixels
    }

    // MARK: - Face Rendering

    private func renderFace(_ faceData: FaceData, in context: CGContext) {
        let pixels = PixelPatterns.facePixels(for: faceData.faceShape, gridSize: gridSize)
        let color = cgColor(from: faceData.skinTone.color)
        fillPixels(pixels, color: color, in: context)
    }

    // MARK: - Hair Rendering

    private func renderHairBack(_ faceData: FaceData, in context: CGContext) {
        guard faceData.hairStyle != .bald else { return }
        let pixels = PixelPatterns.hairBackPixels(for: faceData.hairStyle, gridSize: gridSize)
        let color = cgColor(from: faceData.hairColor.shadowColor)
        fillPixels(pixels, color: color, in: context)
    }

    private func renderHairFront(_ faceData: FaceData, in context: CGContext) {
        guard faceData.hairStyle != .bald else { return }
        let pixels = PixelPatterns.hairFrontPixels(for: faceData.hairStyle, gridSize: gridSize)
        let color = cgColor(from: faceData.hairColor.color)
        fillPixels(pixels, color: color, in: context)
    }

    // MARK: - Ears Rendering

    private func renderEars(_ faceData: FaceData, in context: CGContext) {
        let color = cgColor(from: faceData.skinTone.color)
        // Left ear
        let leftEar = ellipsePixels(centerX: 4, centerY: 14, radiusX: 2, radiusY: 2)
        fillPixels(leftEar, color: color, in: context)
        // Right ear
        let rightEar = ellipsePixels(centerX: 27, centerY: 14, radiusX: 2, radiusY: 2)
        fillPixels(rightEar, color: color, in: context)
    }

    // MARK: - Eyes Rendering

    private func renderEyes(_ faceData: FaceData, in context: CGContext) {
        let (leftPixels, rightPixels) = PixelPatterns.eyePixels(
            for: faceData.eyes,
            eyeColor: cgColor(from: faceData.eyeColor.color),
            gridSize: gridSize
        )

        // Render left eye
        for (pixels, color) in leftPixels {
            fillPixels(pixels, color: color, in: context)
        }

        // Render right eye
        for (pixels, color) in rightPixels {
            fillPixels(pixels, color: color, in: context)
        }
    }

    // MARK: - Eyebrows Rendering

    private func renderEyebrows(_ faceData: FaceData, in context: CGContext) {
        let pixels = PixelPatterns.eyebrowPixels(for: faceData.eyebrows, gridSize: gridSize)
        let color = cgColor(from: faceData.hairColor.color)
        fillPixels(pixels, color: color, in: context)
    }

    // MARK: - Nose Rendering

    private func renderNose(_ faceData: FaceData, in context: CGContext) {
        let pixels = PixelPatterns.nosePixels(for: faceData.nose, gridSize: gridSize)
        let color = cgColor(from: faceData.skinTone.shadowColor)
        fillPixels(pixels, color: color, in: context)
    }

    // MARK: - Mouth Rendering

    private func renderMouth(_ faceData: FaceData, in context: CGContext) {
        let pixels = PixelPatterns.mouthPixels(for: faceData.mouth, gridSize: gridSize)
        // Lip color - pink/brown tone
        let lipColor = CGColor(red: 0.75, green: 0.45, blue: 0.45, alpha: 1.0)
        fillPixels(pixels, color: lipColor, in: context)
    }

    // MARK: - Accessories Rendering

    private func renderAccessories(_ faceData: FaceData, in context: CGContext) {
        if let glasses = faceData.accessories.glasses {
            renderGlasses(glasses, in: context)
        }

        if let facialHair = faceData.accessories.facialHair {
            renderFacialHair(facialHair, hairColor: faceData.hairColor, in: context)
        }

        if let earrings = faceData.accessories.earrings {
            renderEarrings(earrings, in: context)
        }
    }

    private func renderGlasses(_ glasses: Accessories.Glasses, in context: CGContext) {
        let pixels = PixelPatterns.glassesPixels(for: glasses, gridSize: gridSize)
        let color = cgColor(from: glasses.frameColor)
        fillPixels(pixels, color: color, in: context)

        // Lens tint (semi-transparent)
        let lensPixels = PixelPatterns.lensPixels(for: glasses, gridSize: gridSize)
        let lensColor = CGColor(red: 0.9, green: 0.95, blue: 1.0, alpha: 0.3)
        fillPixels(lensPixels, color: lensColor, in: context)
    }

    private func renderFacialHair(_ facialHair: Accessories.FacialHair, hairColor: HairColor, in context: CGContext) {
        let pixels = PixelPatterns.facialHairPixels(for: facialHair, gridSize: gridSize)
        let color = cgColor(from: hairColor.color)
        fillPixels(pixels, color: color, in: context)
    }

    private func renderEarrings(_ earrings: Accessories.Earrings, in context: CGContext) {
        let pixels = PixelPatterns.earringPixels(for: earrings, gridSize: gridSize)
        let color = cgColor(from: earrings.color)
        fillPixels(pixels, color: color, in: context)
    }

    // MARK: - Color Conversion

    /// Convert SwiftUI Color to CGColor.
    private func cgColor(from color: Color) -> CGColor {
        #if canImport(UIKit)
            return UIColor(color).cgColor
        #elseif canImport(AppKit)
            return NSColor(color).cgColor
        #endif
    }
}
