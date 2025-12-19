import SwiftUI

/// SwiftUI view that renders a face avatar.
///
/// Example:
/// ```swift
/// AvatarView(faceData: faceData, style: .cartoon, size: 64)
/// ```
public struct AvatarView: View, Sendable {
    /// The face data to render.
    public let faceData: FaceData

    /// The rendering style.
    public let style: AvatarStyle

    /// The size of the avatar (width and height).
    public let size: CGFloat

    /// Create an avatar view.
    /// - Parameters:
    ///   - faceData: The face data to render.
    ///   - style: The visual style (default: .cartoon).
    ///   - size: The size in points (default: 64).
    public init(faceData: FaceData, style: AvatarStyle = .cartoon, size: CGFloat = 64) {
        self.faceData = faceData
        self.style = style
        self.size = size
    }

    public var body: some View {
        Canvas { context, canvasSize in
            let config = style.configuration
            let rect = CGRect(origin: .zero, size: canvasSize)

            // Render layers in order (back to front)
            renderFace(context: &context, rect: rect, config: config)
            renderHairBack(context: &context, rect: rect, config: config)
            renderEars(context: &context, rect: rect, config: config)
            renderEyebrows(context: &context, rect: rect, config: config)
            renderEyes(context: &context, rect: rect, config: config)
            renderNose(context: &context, rect: rect, config: config)
            renderMouth(context: &context, rect: rect, config: config)
            renderHairFront(context: &context, rect: rect, config: config)
            renderAccessories(context: &context, rect: rect, config: config)
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
        .background(Circle().fill(Color.white.opacity(0.1)))
    }

    // MARK: - Face Rendering

    private func renderFace(context: inout GraphicsContext, rect: CGRect, config: StyleConfiguration) {
        let path = facePath(in: rect)

        // Fill with skin tone
        context.fill(path, with: .color(faceData.skinTone.color))

        // Stroke for cartoon style
        if config.strokeWidth > 0 {
            context.stroke(
                path,
                with: .color(.black.opacity(0.3)),
                lineWidth: config.strokeWidth
            )
        }
    }

    private func facePath(in rect: CGRect) -> Path {
        let inset = rect.width * 0.08
        let faceRect = rect.insetBy(dx: inset, dy: inset * 0.5)

        switch faceData.faceShape {
        case .oval:
            return Path(ellipseIn: faceRect.insetBy(dx: rect.width * 0.02, dy: 0))
        case .round:
            return Path(ellipseIn: faceRect)
        case .square:
            return Path(roundedRect: faceRect, cornerRadius: rect.width * 0.15)
        case .heart:
            return heartPath(in: faceRect)
        case .oblong:
            return Path(ellipseIn: faceRect.insetBy(dx: rect.width * 0.05, dy: -rect.height * 0.02))
        case .diamond:
            return diamondPath(in: faceRect)
        }
    }

    private func heartPath(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height

        path.move(to: CGPoint(x: rect.midX, y: rect.maxY - height * 0.1))
        path.addCurve(
            to: CGPoint(x: rect.minX + width * 0.1, y: rect.minY + height * 0.35),
            control1: CGPoint(x: rect.minX + width * 0.1, y: rect.maxY - height * 0.2),
            control2: CGPoint(x: rect.minX, y: rect.minY + height * 0.5)
        )
        path.addCurve(
            to: CGPoint(x: rect.midX, y: rect.minY + height * 0.15),
            control1: CGPoint(x: rect.minX + width * 0.15, y: rect.minY + height * 0.1),
            control2: CGPoint(x: rect.midX - width * 0.1, y: rect.minY + height * 0.1)
        )
        path.addCurve(
            to: CGPoint(x: rect.maxX - width * 0.1, y: rect.minY + height * 0.35),
            control1: CGPoint(x: rect.midX + width * 0.1, y: rect.minY + height * 0.1),
            control2: CGPoint(x: rect.maxX - width * 0.15, y: rect.minY + height * 0.1)
        )
        path.addCurve(
            to: CGPoint(x: rect.midX, y: rect.maxY - height * 0.1),
            control1: CGPoint(x: rect.maxX, y: rect.minY + height * 0.5),
            control2: CGPoint(x: rect.maxX - width * 0.1, y: rect.maxY - height * 0.2)
        )
        path.closeSubpath()

        return path
    }

    private func diamondPath(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY + rect.height * 0.05))
        path.addLine(to: CGPoint(x: rect.maxX - rect.width * 0.1, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY - rect.height * 0.05))
        path.addLine(to: CGPoint(x: rect.minX + rect.width * 0.1, y: rect.midY))
        path.closeSubpath()
        return path
    }

    // MARK: - Eyes Rendering

    private func renderEyes(context: inout GraphicsContext, rect: CGRect, config: StyleConfiguration) {
        let leftEyeCenter = CGPoint(x: rect.width * 0.35, y: rect.height * 0.42)
        let rightEyeCenter = CGPoint(x: rect.width * 0.65, y: rect.height * 0.42)
        let eyeWidth = rect.width * 0.12
        let eyeHeight = rect.width * 0.08

        // Eye whites
        let leftEyeRect = CGRect(
            x: leftEyeCenter.x - eyeWidth / 2,
            y: leftEyeCenter.y - eyeHeight / 2,
            width: eyeWidth,
            height: eyeHeight
        )
        let rightEyeRect = CGRect(
            x: rightEyeCenter.x - eyeWidth / 2,
            y: rightEyeCenter.y - eyeHeight / 2,
            width: eyeWidth,
            height: eyeHeight
        )

        let leftEyePath = eyePath(style: faceData.eyes, in: leftEyeRect, isLeft: true)
        let rightEyePath = eyePath(style: faceData.eyes, in: rightEyeRect, isLeft: false)

        // White of eyes
        context.fill(leftEyePath, with: .color(.white))
        context.fill(rightEyePath, with: .color(.white))

        // Iris
        let irisRadius = eyeWidth * 0.35
        let leftIris = Path(ellipseIn: CGRect(
            x: leftEyeCenter.x - irisRadius / 2,
            y: leftEyeCenter.y - irisRadius / 2,
            width: irisRadius,
            height: irisRadius
        ))
        let rightIris = Path(ellipseIn: CGRect(
            x: rightEyeCenter.x - irisRadius / 2,
            y: rightEyeCenter.y - irisRadius / 2,
            width: irisRadius,
            height: irisRadius
        ))

        context.fill(leftIris, with: .color(faceData.eyeColor.color))
        context.fill(rightIris, with: .color(faceData.eyeColor.color))

        // Pupil
        let pupilRadius = irisRadius * 0.5
        let leftPupil = Path(ellipseIn: CGRect(
            x: leftEyeCenter.x - pupilRadius / 2,
            y: leftEyeCenter.y - pupilRadius / 2,
            width: pupilRadius,
            height: pupilRadius
        ))
        let rightPupil = Path(ellipseIn: CGRect(
            x: rightEyeCenter.x - pupilRadius / 2,
            y: rightEyeCenter.y - pupilRadius / 2,
            width: pupilRadius,
            height: pupilRadius
        ))

        context.fill(leftPupil, with: .color(.black))
        context.fill(rightPupil, with: .color(.black))

        // Highlight
        if config.shadowEnabled {
            let highlightRadius = pupilRadius * 0.4
            let leftHighlight = Path(ellipseIn: CGRect(
                x: leftEyeCenter.x - pupilRadius * 0.3,
                y: leftEyeCenter.y - pupilRadius * 0.3,
                width: highlightRadius,
                height: highlightRadius
            ))
            let rightHighlight = Path(ellipseIn: CGRect(
                x: rightEyeCenter.x - pupilRadius * 0.3,
                y: rightEyeCenter.y - pupilRadius * 0.3,
                width: highlightRadius,
                height: highlightRadius
            ))
            context.fill(leftHighlight, with: .color(.white.opacity(0.8)))
            context.fill(rightHighlight, with: .color(.white.opacity(0.8)))
        }

        // Stroke
        if config.strokeWidth > 0 {
            context.stroke(leftEyePath, with: .color(.black.opacity(0.4)), lineWidth: config.strokeWidth * 0.5)
            context.stroke(rightEyePath, with: .color(.black.opacity(0.4)), lineWidth: config.strokeWidth * 0.5)
        }
    }

    private func eyePath(style: Eyes, in rect: CGRect, isLeft: Bool) -> Path {
        switch style {
        case .round:
            return Path(ellipseIn: rect)
        case .almond:
            return almondEyePath(in: rect)
        case .hooded:
            return hoodedEyePath(in: rect)
        case .upturned:
            return upturnedEyePath(in: rect, isLeft: isLeft)
        case .downturned:
            return downturnedEyePath(in: rect, isLeft: isLeft)
        case .wide:
            let wideRect = rect.insetBy(dx: -rect.width * 0.1, dy: 0)
            return Path(ellipseIn: wideRect)
        case .narrow:
            let narrowRect = rect.insetBy(dx: 0, dy: rect.height * 0.2)
            return Path(ellipseIn: narrowRect)
        case .wink:
            if isLeft {
                return winkEyePath(in: rect)
            } else {
                return Path(ellipseIn: rect)
            }
        }
    }

    private func almondEyePath(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX, y: rect.midY),
            control: CGPoint(x: rect.midX, y: rect.minY)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.minX, y: rect.midY),
            control: CGPoint(x: rect.midX, y: rect.maxY)
        )
        return path
    }

    private func hoodedEyePath(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY + rect.height * 0.1))
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX, y: rect.midY + rect.height * 0.1),
            control: CGPoint(x: rect.midX, y: rect.minY + rect.height * 0.2)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.minX, y: rect.midY + rect.height * 0.1),
            control: CGPoint(x: rect.midX, y: rect.maxY)
        )
        return path
    }

    private func upturnedEyePath(in rect: CGRect, isLeft: Bool) -> Path {
        var path = Path()
        let offset: CGFloat = isLeft ? -rect.height * 0.15 : rect.height * 0.15
        path.move(to: CGPoint(x: rect.minX, y: rect.midY + offset))
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX, y: rect.midY - offset),
            control: CGPoint(x: rect.midX, y: rect.minY)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.minX, y: rect.midY + offset),
            control: CGPoint(x: rect.midX, y: rect.maxY)
        )
        return path
    }

    private func downturnedEyePath(in rect: CGRect, isLeft: Bool) -> Path {
        var path = Path()
        let offset: CGFloat = isLeft ? rect.height * 0.15 : -rect.height * 0.15
        path.move(to: CGPoint(x: rect.minX, y: rect.midY + offset))
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX, y: rect.midY - offset),
            control: CGPoint(x: rect.midX, y: rect.minY)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.minX, y: rect.midY + offset),
            control: CGPoint(x: rect.midX, y: rect.maxY)
        )
        return path
    }

    private func winkEyePath(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }

    // MARK: - Eyebrows Rendering

    private func renderEyebrows(context: inout GraphicsContext, rect: CGRect, config: StyleConfiguration) {
        let leftBrowCenter = CGPoint(x: rect.width * 0.35, y: rect.height * 0.32)
        let rightBrowCenter = CGPoint(x: rect.width * 0.65, y: rect.height * 0.32)
        let browWidth = rect.width * 0.14
        let browHeight = rect.width * 0.025

        let leftBrowPath = eyebrowPath(
            style: faceData.eyebrows,
            center: leftBrowCenter,
            width: browWidth,
            height: browHeight,
            isLeft: true
        )
        let rightBrowPath = eyebrowPath(
            style: faceData.eyebrows,
            center: rightBrowCenter,
            width: browWidth,
            height: browHeight,
            isLeft: false
        )

        context.fill(leftBrowPath, with: .color(faceData.hairColor.color))
        context.fill(rightBrowPath, with: .color(faceData.hairColor.color))
    }

    private func eyebrowPath(style: Eyebrows, center: CGPoint, width: CGFloat, height: CGFloat, isLeft: Bool) -> Path {
        var path = Path()
        let startX = center.x - width / 2
        let endX = center.x + width / 2

        switch style {
        case .natural:
            path.move(to: CGPoint(x: startX, y: center.y))
            path.addQuadCurve(
                to: CGPoint(x: endX, y: center.y),
                control: CGPoint(x: center.x, y: center.y - height * 2)
            )
            path.addQuadCurve(
                to: CGPoint(x: startX, y: center.y),
                control: CGPoint(x: center.x, y: center.y + height)
            )
        case .arched:
            let archOffset = isLeft ? -height * 3 : -height * 3
            path.move(to: CGPoint(x: startX, y: center.y + height))
            path.addQuadCurve(
                to: CGPoint(x: endX, y: center.y),
                control: CGPoint(x: center.x + (isLeft ? -width * 0.1 : width * 0.1), y: center.y + archOffset)
            )
            path.addLine(to: CGPoint(x: endX, y: center.y + height))
            path.addQuadCurve(
                to: CGPoint(x: startX, y: center.y + height),
                control: CGPoint(x: center.x, y: center.y + height * 2)
            )
        case .straight:
            path.addRect(CGRect(x: startX, y: center.y - height / 2, width: width, height: height))
        case .thick:
            path.move(to: CGPoint(x: startX, y: center.y))
            path.addQuadCurve(
                to: CGPoint(x: endX, y: center.y),
                control: CGPoint(x: center.x, y: center.y - height * 3)
            )
            path.addQuadCurve(
                to: CGPoint(x: startX, y: center.y),
                control: CGPoint(x: center.x, y: center.y + height * 2)
            )
        case .thin:
            path.move(to: CGPoint(x: startX, y: center.y))
            path.addQuadCurve(
                to: CGPoint(x: endX, y: center.y),
                control: CGPoint(x: center.x, y: center.y - height)
            )
            path.addQuadCurve(
                to: CGPoint(x: startX, y: center.y),
                control: CGPoint(x: center.x, y: center.y + height * 0.5)
            )
        case .raised:
            let raiseOffset: CGFloat = -height * 2
            path.move(to: CGPoint(x: startX, y: center.y + raiseOffset))
            path.addQuadCurve(
                to: CGPoint(x: endX, y: center.y + raiseOffset * 0.5),
                control: CGPoint(x: center.x, y: center.y + raiseOffset - height * 2)
            )
            path.addQuadCurve(
                to: CGPoint(x: startX, y: center.y + raiseOffset),
                control: CGPoint(x: center.x, y: center.y + raiseOffset + height)
            )
        }

        return path
    }

    // MARK: - Nose Rendering

    private func renderNose(context: inout GraphicsContext, rect: CGRect, config: StyleConfiguration) {
        let noseCenter = CGPoint(x: rect.width * 0.5, y: rect.height * 0.55)
        let noseWidth = rect.width * 0.08
        let noseHeight = rect.width * 0.12

        let nosePath = nosePath(
            style: faceData.nose,
            center: noseCenter,
            width: noseWidth,
            height: noseHeight
        )

        context.fill(nosePath, with: .color(faceData.skinTone.shadowColor))

        if config.strokeWidth > 0 {
            context.stroke(nosePath, with: .color(.black.opacity(0.2)), lineWidth: config.strokeWidth * 0.5)
        }
    }

    private func nosePath(style: Nose, center: CGPoint, width: CGFloat, height: CGFloat) -> Path {
        var path = Path()

        switch style {
        case .small:
            path.addEllipse(in: CGRect(
                x: center.x - width * 0.3,
                y: center.y,
                width: width * 0.6,
                height: height * 0.4
            ))
        case .medium:
            path.move(to: CGPoint(x: center.x, y: center.y - height * 0.3))
            path.addQuadCurve(
                to: CGPoint(x: center.x + width * 0.4, y: center.y + height * 0.3),
                control: CGPoint(x: center.x + width * 0.3, y: center.y)
            )
            path.addQuadCurve(
                to: CGPoint(x: center.x - width * 0.4, y: center.y + height * 0.3),
                control: CGPoint(x: center.x, y: center.y + height * 0.5)
            )
            path.addQuadCurve(
                to: CGPoint(x: center.x, y: center.y - height * 0.3),
                control: CGPoint(x: center.x - width * 0.3, y: center.y)
            )
        case .large:
            path.move(to: CGPoint(x: center.x, y: center.y - height * 0.4))
            path.addQuadCurve(
                to: CGPoint(x: center.x + width * 0.5, y: center.y + height * 0.4),
                control: CGPoint(x: center.x + width * 0.4, y: center.y)
            )
            path.addQuadCurve(
                to: CGPoint(x: center.x - width * 0.5, y: center.y + height * 0.4),
                control: CGPoint(x: center.x, y: center.y + height * 0.6)
            )
            path.addQuadCurve(
                to: CGPoint(x: center.x, y: center.y - height * 0.4),
                control: CGPoint(x: center.x - width * 0.4, y: center.y)
            )
        case .pointed:
            path.move(to: CGPoint(x: center.x, y: center.y - height * 0.3))
            path.addLine(to: CGPoint(x: center.x + width * 0.3, y: center.y + height * 0.3))
            path.addQuadCurve(
                to: CGPoint(x: center.x - width * 0.3, y: center.y + height * 0.3),
                control: CGPoint(x: center.x, y: center.y + height * 0.4)
            )
            path.closeSubpath()
        case .rounded:
            path.addEllipse(in: CGRect(
                x: center.x - width * 0.4,
                y: center.y - height * 0.1,
                width: width * 0.8,
                height: height * 0.5
            ))
        case .button:
            path.addEllipse(in: CGRect(
                x: center.x - width * 0.25,
                y: center.y,
                width: width * 0.5,
                height: height * 0.3
            ))
        }

        return path
    }

    // MARK: - Mouth Rendering

    private func renderMouth(context: inout GraphicsContext, rect: CGRect, config: StyleConfiguration) {
        let mouthCenter = CGPoint(x: rect.width * 0.5, y: rect.height * 0.72)
        let mouthWidth = rect.width * 0.18
        let mouthHeight = rect.width * 0.06

        let mouthPath = mouthPath(
            style: faceData.mouth,
            center: mouthCenter,
            width: mouthWidth,
            height: mouthHeight
        )

        // Lip color
        let lipColor = Color(red: 0.75, green: 0.45, blue: 0.45)
        context.fill(mouthPath, with: .color(lipColor))

        if config.strokeWidth > 0 {
            context.stroke(mouthPath, with: .color(.black.opacity(0.3)), lineWidth: config.strokeWidth * 0.5)
        }
    }

    private func mouthPath(style: Mouth, center: CGPoint, width: CGFloat, height: CGFloat) -> Path {
        var path = Path()

        switch style {
        case .smile:
            path.move(to: CGPoint(x: center.x - width / 2, y: center.y))
            path.addQuadCurve(
                to: CGPoint(x: center.x + width / 2, y: center.y),
                control: CGPoint(x: center.x, y: center.y + height * 2)
            )
            path.addQuadCurve(
                to: CGPoint(x: center.x - width / 2, y: center.y),
                control: CGPoint(x: center.x, y: center.y + height)
            )
        case .neutral:
            path.addRect(CGRect(
                x: center.x - width * 0.3,
                y: center.y - height * 0.3,
                width: width * 0.6,
                height: height * 0.6
            ))
        case .slight:
            path.move(to: CGPoint(x: center.x - width * 0.3, y: center.y))
            path.addQuadCurve(
                to: CGPoint(x: center.x + width * 0.3, y: center.y),
                control: CGPoint(x: center.x, y: center.y + height * 0.8)
            )
            path.addQuadCurve(
                to: CGPoint(x: center.x - width * 0.3, y: center.y),
                control: CGPoint(x: center.x, y: center.y + height * 0.3)
            )
        case .grin:
            path.move(to: CGPoint(x: center.x - width / 2, y: center.y - height * 0.3))
            path.addQuadCurve(
                to: CGPoint(x: center.x + width / 2, y: center.y - height * 0.3),
                control: CGPoint(x: center.x, y: center.y + height * 2.5)
            )
            path.addQuadCurve(
                to: CGPoint(x: center.x - width / 2, y: center.y - height * 0.3),
                control: CGPoint(x: center.x, y: center.y + height * 1.5)
            )
        case .pout:
            path.addEllipse(in: CGRect(
                x: center.x - width * 0.25,
                y: center.y - height * 0.5,
                width: width * 0.5,
                height: height * 1.2
            ))
        case .open:
            path.addEllipse(in: CGRect(
                x: center.x - width * 0.3,
                y: center.y - height * 0.3,
                width: width * 0.6,
                height: height * 1.5
            ))
        case .smirk:
            path.move(to: CGPoint(x: center.x - width * 0.3, y: center.y))
            path.addQuadCurve(
                to: CGPoint(x: center.x + width * 0.4, y: center.y - height * 0.3),
                control: CGPoint(x: center.x, y: center.y + height * 0.8)
            )
            path.addQuadCurve(
                to: CGPoint(x: center.x - width * 0.3, y: center.y),
                control: CGPoint(x: center.x, y: center.y + height * 0.3)
            )
        case .serious:
            path.move(to: CGPoint(x: center.x - width * 0.35, y: center.y))
            path.addLine(to: CGPoint(x: center.x + width * 0.35, y: center.y))
            path.addLine(to: CGPoint(x: center.x + width * 0.35, y: center.y + height * 0.4))
            path.addLine(to: CGPoint(x: center.x - width * 0.35, y: center.y + height * 0.4))
            path.closeSubpath()
        }

        return path
    }

    // MARK: - Hair Rendering

    private func renderHairBack(context: inout GraphicsContext, rect: CGRect, config: StyleConfiguration) {
        guard faceData.hairStyle != .bald && faceData.hairStyle != .buzz else { return }

        let hairPath = hairBackPath(in: rect)
        context.fill(hairPath, with: .color(faceData.hairColor.shadowColor))
    }

    private func renderHairFront(context: inout GraphicsContext, rect: CGRect, config: StyleConfiguration) {
        guard faceData.hairStyle != .bald else { return }

        let hairPath = hairFrontPath(in: rect)
        context.fill(hairPath, with: .color(faceData.hairColor.color))

        if config.strokeWidth > 0 {
            context.stroke(hairPath, with: .color(.black.opacity(0.2)), lineWidth: config.strokeWidth * 0.5)
        }
    }

    private func hairBackPath(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height

        switch faceData.hairStyle {
        case .bald, .buzz:
            break
        case .short:
            path.addEllipse(in: CGRect(
                x: width * 0.15,
                y: height * 0.05,
                width: width * 0.7,
                height: height * 0.35
            ))
        case .medium, .wavy:
            path.addEllipse(in: CGRect(
                x: width * 0.1,
                y: height * 0.02,
                width: width * 0.8,
                height: height * 0.45
            ))
        case .long:
            path.addEllipse(in: CGRect(
                x: width * 0.05,
                y: height * 0.0,
                width: width * 0.9,
                height: height * 0.55
            ))
            // Side hair
            path.addRect(CGRect(x: width * 0.05, y: height * 0.3, width: width * 0.12, height: height * 0.5))
            path.addRect(CGRect(x: width * 0.83, y: height * 0.3, width: width * 0.12, height: height * 0.5))
        case .curly:
            for i in 0..<8 {
                let angle = Double(i) * .pi / 4
                let x = width * 0.5 + cos(angle) * width * 0.35
                let y = height * 0.2 + sin(angle) * height * 0.15
                path.addEllipse(in: CGRect(x: x - width * 0.08, y: y, width: width * 0.16, height: height * 0.12))
            }
        case .spiky:
            break // Handled in front
        case .mohawk:
            break // Handled in front
        case .ponytail:
            path.addEllipse(in: CGRect(
                x: width * 0.15,
                y: height * 0.02,
                width: width * 0.7,
                height: height * 0.35
            ))
            // Ponytail
            path.addEllipse(in: CGRect(
                x: width * 0.35,
                y: height * 0.0,
                width: width * 0.3,
                height: height * 0.15
            ))
        case .bun:
            path.addEllipse(in: CGRect(
                x: width * 0.15,
                y: height * 0.05,
                width: width * 0.7,
                height: height * 0.3
            ))
        case .afro:
            path.addEllipse(in: CGRect(
                x: width * 0.0,
                y: height * -0.05,
                width: width * 1.0,
                height: height * 0.6
            ))
        }

        return path
    }

    private func hairFrontPath(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height

        switch faceData.hairStyle {
        case .bald:
            break
        case .short:
            path.move(to: CGPoint(x: width * 0.2, y: height * 0.2))
            path.addQuadCurve(
                to: CGPoint(x: width * 0.8, y: height * 0.2),
                control: CGPoint(x: width * 0.5, y: height * 0.08)
            )
            path.addQuadCurve(
                to: CGPoint(x: width * 0.2, y: height * 0.2),
                control: CGPoint(x: width * 0.5, y: height * 0.25)
            )
        case .medium:
            path.move(to: CGPoint(x: width * 0.15, y: height * 0.25))
            path.addQuadCurve(
                to: CGPoint(x: width * 0.85, y: height * 0.25),
                control: CGPoint(x: width * 0.5, y: height * 0.05)
            )
            path.addQuadCurve(
                to: CGPoint(x: width * 0.15, y: height * 0.25),
                control: CGPoint(x: width * 0.5, y: height * 0.32)
            )
        case .long:
            path.move(to: CGPoint(x: width * 0.1, y: height * 0.28))
            path.addQuadCurve(
                to: CGPoint(x: width * 0.9, y: height * 0.28),
                control: CGPoint(x: width * 0.5, y: height * 0.03)
            )
            path.addQuadCurve(
                to: CGPoint(x: width * 0.1, y: height * 0.28),
                control: CGPoint(x: width * 0.5, y: height * 0.35)
            )
        case .curly:
            for i in 0..<6 {
                let xOffset = CGFloat(i) * width * 0.12 + width * 0.18
                path.addEllipse(in: CGRect(
                    x: xOffset,
                    y: height * 0.1,
                    width: width * 0.12,
                    height: height * 0.1
                ))
            }
        case .wavy:
            path.move(to: CGPoint(x: width * 0.12, y: height * 0.26))
            for i in 0..<5 {
                let xBase = width * 0.12 + CGFloat(i) * width * 0.19
                let yOffset = i % 2 == 0 ? height * 0.1 : height * 0.15
                path.addQuadCurve(
                    to: CGPoint(x: xBase + width * 0.19, y: height * 0.26),
                    control: CGPoint(x: xBase + width * 0.095, y: yOffset)
                )
            }
            path.addQuadCurve(
                to: CGPoint(x: width * 0.12, y: height * 0.26),
                control: CGPoint(x: width * 0.5, y: height * 0.32)
            )
        case .spiky:
            for i in 0..<7 {
                let xBase = width * 0.18 + CGFloat(i) * width * 0.1
                var spike = Path()
                spike.move(to: CGPoint(x: xBase, y: height * 0.22))
                spike.addLine(to: CGPoint(x: xBase + width * 0.05, y: height * 0.02 + CGFloat(i % 3) * height * 0.03))
                spike.addLine(to: CGPoint(x: xBase + width * 0.1, y: height * 0.22))
                spike.closeSubpath()
                path.addPath(spike)
            }
        case .buzz:
            path.move(to: CGPoint(x: width * 0.2, y: height * 0.18))
            path.addQuadCurve(
                to: CGPoint(x: width * 0.8, y: height * 0.18),
                control: CGPoint(x: width * 0.5, y: height * 0.1)
            )
            path.addQuadCurve(
                to: CGPoint(x: width * 0.2, y: height * 0.18),
                control: CGPoint(x: width * 0.5, y: height * 0.22)
            )
        case .mohawk:
            path.move(to: CGPoint(x: width * 0.4, y: height * 0.25))
            path.addLine(to: CGPoint(x: width * 0.5, y: height * -0.05))
            path.addLine(to: CGPoint(x: width * 0.6, y: height * 0.25))
            path.addQuadCurve(
                to: CGPoint(x: width * 0.4, y: height * 0.25),
                control: CGPoint(x: width * 0.5, y: height * 0.28)
            )
        case .ponytail:
            path.move(to: CGPoint(x: width * 0.2, y: height * 0.22))
            path.addQuadCurve(
                to: CGPoint(x: width * 0.8, y: height * 0.22),
                control: CGPoint(x: width * 0.5, y: height * 0.08)
            )
            path.addQuadCurve(
                to: CGPoint(x: width * 0.2, y: height * 0.22),
                control: CGPoint(x: width * 0.5, y: height * 0.28)
            )
        case .bun:
            // Front hair
            path.move(to: CGPoint(x: width * 0.2, y: height * 0.22))
            path.addQuadCurve(
                to: CGPoint(x: width * 0.8, y: height * 0.22),
                control: CGPoint(x: width * 0.5, y: height * 0.1)
            )
            path.addQuadCurve(
                to: CGPoint(x: width * 0.2, y: height * 0.22),
                control: CGPoint(x: width * 0.5, y: height * 0.28)
            )
            // Bun on top
            path.addEllipse(in: CGRect(
                x: width * 0.35,
                y: height * -0.02,
                width: width * 0.3,
                height: height * 0.15
            ))
        case .afro:
            path.addEllipse(in: CGRect(
                x: width * 0.05,
                y: height * 0.0,
                width: width * 0.9,
                height: height * 0.4
            ))
        }

        return path
    }

    // MARK: - Ears Rendering

    private func renderEars(context: inout GraphicsContext, rect: CGRect, config: StyleConfiguration) {
        let earWidth = rect.width * 0.08
        let earHeight = rect.width * 0.1

        let leftEar = Path(ellipseIn: CGRect(
            x: rect.width * 0.08,
            y: rect.height * 0.4,
            width: earWidth,
            height: earHeight
        ))
        let rightEar = Path(ellipseIn: CGRect(
            x: rect.width * 0.84,
            y: rect.height * 0.4,
            width: earWidth,
            height: earHeight
        ))

        context.fill(leftEar, with: .color(faceData.skinTone.color))
        context.fill(rightEar, with: .color(faceData.skinTone.color))

        if config.strokeWidth > 0 {
            context.stroke(leftEar, with: .color(.black.opacity(0.2)), lineWidth: config.strokeWidth * 0.3)
            context.stroke(rightEar, with: .color(.black.opacity(0.2)), lineWidth: config.strokeWidth * 0.3)
        }
    }

    // MARK: - Accessories Rendering

    private func renderAccessories(context: inout GraphicsContext, rect: CGRect, config: StyleConfiguration) {
        if let glasses = faceData.accessories.glasses {
            renderGlasses(glasses, context: &context, rect: rect, config: config)
        }

        if let facialHair = faceData.accessories.facialHair {
            renderFacialHair(facialHair, context: &context, rect: rect, config: config)
        }

        if let earrings = faceData.accessories.earrings {
            renderEarrings(earrings, context: &context, rect: rect, config: config)
        }
    }

    private func renderGlasses(_ glasses: Accessories.Glasses, context: inout GraphicsContext, rect: CGRect, config: StyleConfiguration) {
        let leftCenter = CGPoint(x: rect.width * 0.35, y: rect.height * 0.42)
        let rightCenter = CGPoint(x: rect.width * 0.65, y: rect.height * 0.42)
        let glassWidth = rect.width * 0.16
        let glassHeight = rect.width * 0.12
        let frameWidth: CGFloat = 2

        var leftLens: Path
        var rightLens: Path

        switch glasses {
        case .round:
            leftLens = Path(ellipseIn: CGRect(
                x: leftCenter.x - glassWidth / 2,
                y: leftCenter.y - glassHeight / 2,
                width: glassWidth,
                height: glassHeight
            ))
            rightLens = Path(ellipseIn: CGRect(
                x: rightCenter.x - glassWidth / 2,
                y: rightCenter.y - glassHeight / 2,
                width: glassWidth,
                height: glassHeight
            ))
        case .rectangular:
            leftLens = Path(roundedRect: CGRect(
                x: leftCenter.x - glassWidth / 2,
                y: leftCenter.y - glassHeight * 0.4,
                width: glassWidth,
                height: glassHeight * 0.8
            ), cornerRadius: 2)
            rightLens = Path(roundedRect: CGRect(
                x: rightCenter.x - glassWidth / 2,
                y: rightCenter.y - glassHeight * 0.4,
                width: glassWidth,
                height: glassHeight * 0.8
            ), cornerRadius: 2)
        case .aviator:
            leftLens = Path(ellipseIn: CGRect(
                x: leftCenter.x - glassWidth * 0.6,
                y: leftCenter.y - glassHeight * 0.5,
                width: glassWidth * 1.2,
                height: glassHeight * 1.1
            ))
            rightLens = Path(ellipseIn: CGRect(
                x: rightCenter.x - glassWidth * 0.6,
                y: rightCenter.y - glassHeight * 0.5,
                width: glassWidth * 1.2,
                height: glassHeight * 1.1
            ))
        case .catEye:
            leftLens = catEyeLensPath(center: leftCenter, width: glassWidth, height: glassHeight, isLeft: true)
            rightLens = catEyeLensPath(center: rightCenter, width: glassWidth, height: glassHeight, isLeft: false)
        case .rimless:
            leftLens = Path(ellipseIn: CGRect(
                x: leftCenter.x - glassWidth / 2,
                y: leftCenter.y - glassHeight / 2,
                width: glassWidth,
                height: glassHeight
            ))
            rightLens = Path(ellipseIn: CGRect(
                x: rightCenter.x - glassWidth / 2,
                y: rightCenter.y - glassHeight / 2,
                width: glassWidth,
                height: glassHeight
            ))
        }

        // Lens tint
        context.fill(leftLens, with: .color(.white.opacity(0.3)))
        context.fill(rightLens, with: .color(.white.opacity(0.3)))

        // Frames (except rimless)
        if glasses != .rimless {
            context.stroke(leftLens, with: .color(glasses.frameColor), lineWidth: frameWidth)
            context.stroke(rightLens, with: .color(glasses.frameColor), lineWidth: frameWidth)

            // Bridge
            var bridge = Path()
            bridge.move(to: CGPoint(x: leftCenter.x + glassWidth / 2, y: leftCenter.y))
            bridge.addLine(to: CGPoint(x: rightCenter.x - glassWidth / 2, y: rightCenter.y))
            context.stroke(bridge, with: .color(glasses.frameColor), lineWidth: frameWidth)
        }
    }

    private func catEyeLensPath(center: CGPoint, width: CGFloat, height: CGFloat, isLeft: Bool) -> Path {
        var path = Path()
        let xOffset = isLeft ? -width * 0.1 : width * 0.1

        path.move(to: CGPoint(x: center.x - width / 2, y: center.y))
        path.addQuadCurve(
            to: CGPoint(x: center.x + xOffset, y: center.y - height * 0.6),
            control: CGPoint(x: center.x - width * 0.3, y: center.y - height * 0.4)
        )
        path.addQuadCurve(
            to: CGPoint(x: center.x + width / 2, y: center.y),
            control: CGPoint(x: center.x + width * 0.3, y: center.y - height * 0.4)
        )
        path.addQuadCurve(
            to: CGPoint(x: center.x - width / 2, y: center.y),
            control: CGPoint(x: center.x, y: center.y + height * 0.5)
        )

        return path
    }

    private func renderFacialHair(_ facialHair: Accessories.FacialHair, context: inout GraphicsContext, rect: CGRect, config: StyleConfiguration) {
        let chinCenter = CGPoint(x: rect.width * 0.5, y: rect.height * 0.78)
        let hairColor = faceData.hairColor.color

        var path = Path()

        switch facialHair {
        case .stubble:
            // Dots pattern for stubble
            for _ in 0..<20 {
                let x = rect.width * 0.3 + CGFloat.random(in: 0...rect.width * 0.4)
                let y = rect.height * 0.65 + CGFloat.random(in: 0...rect.height * 0.2)
                path.addEllipse(in: CGRect(x: x, y: y, width: 2, height: 2))
            }
        case .goatee:
            path.addEllipse(in: CGRect(
                x: chinCenter.x - rect.width * 0.08,
                y: chinCenter.y - rect.height * 0.02,
                width: rect.width * 0.16,
                height: rect.height * 0.12
            ))
        case .fullBeard:
            path.move(to: CGPoint(x: rect.width * 0.2, y: rect.height * 0.6))
            path.addQuadCurve(
                to: CGPoint(x: rect.width * 0.8, y: rect.height * 0.6),
                control: CGPoint(x: rect.width * 0.5, y: rect.height * 0.95)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.width * 0.2, y: rect.height * 0.6),
                control: CGPoint(x: rect.width * 0.5, y: rect.height * 0.7)
            )
        case .mustache:
            path.move(to: CGPoint(x: rect.width * 0.32, y: rect.height * 0.62))
            path.addQuadCurve(
                to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.65),
                control: CGPoint(x: rect.width * 0.4, y: rect.height * 0.58)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.width * 0.68, y: rect.height * 0.62),
                control: CGPoint(x: rect.width * 0.6, y: rect.height * 0.58)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.width * 0.32, y: rect.height * 0.62),
                control: CGPoint(x: rect.width * 0.5, y: rect.height * 0.68)
            )
        case .soulPatch:
            path.addEllipse(in: CGRect(
                x: chinCenter.x - rect.width * 0.03,
                y: rect.height * 0.75,
                width: rect.width * 0.06,
                height: rect.height * 0.06
            ))
        }

        context.fill(path, with: .color(hairColor))
    }

    private func renderEarrings(_ earrings: Accessories.Earrings, context: inout GraphicsContext, rect: CGRect, config: StyleConfiguration) {
        let leftEarBottom = CGPoint(x: rect.width * 0.1, y: rect.height * 0.48)
        let rightEarBottom = CGPoint(x: rect.width * 0.9, y: rect.height * 0.48)

        switch earrings {
        case .studs:
            let studSize = rect.width * 0.03
            context.fill(
                Path(ellipseIn: CGRect(x: leftEarBottom.x - studSize / 2, y: leftEarBottom.y, width: studSize, height: studSize)),
                with: .color(earrings.color)
            )
            context.fill(
                Path(ellipseIn: CGRect(x: rightEarBottom.x - studSize / 2, y: rightEarBottom.y, width: studSize, height: studSize)),
                with: .color(earrings.color)
            )
        case .hoops:
            let hoopSize = rect.width * 0.06
            context.stroke(
                Path(ellipseIn: CGRect(x: leftEarBottom.x - hoopSize / 2, y: leftEarBottom.y, width: hoopSize, height: hoopSize * 1.2)),
                with: .color(earrings.color),
                lineWidth: 1.5
            )
            context.stroke(
                Path(ellipseIn: CGRect(x: rightEarBottom.x - hoopSize / 2, y: rightEarBottom.y, width: hoopSize, height: hoopSize * 1.2)),
                with: .color(earrings.color),
                lineWidth: 1.5
            )
        case .dangles:
            let dangleLength = rect.height * 0.08
            var leftDangle = Path()
            leftDangle.move(to: leftEarBottom)
            leftDangle.addLine(to: CGPoint(x: leftEarBottom.x, y: leftEarBottom.y + dangleLength))
            leftDangle.addEllipse(in: CGRect(
                x: leftEarBottom.x - rect.width * 0.02,
                y: leftEarBottom.y + dangleLength,
                width: rect.width * 0.04,
                height: rect.width * 0.04
            ))

            var rightDangle = Path()
            rightDangle.move(to: rightEarBottom)
            rightDangle.addLine(to: CGPoint(x: rightEarBottom.x, y: rightEarBottom.y + dangleLength))
            rightDangle.addEllipse(in: CGRect(
                x: rightEarBottom.x - rect.width * 0.02,
                y: rightEarBottom.y + dangleLength,
                width: rect.width * 0.04,
                height: rect.width * 0.04
            ))

            context.stroke(leftDangle, with: .color(earrings.color), lineWidth: 1)
            context.fill(leftDangle, with: .color(earrings.color))
            context.stroke(rightDangle, with: .color(earrings.color), lineWidth: 1)
            context.fill(rightDangle, with: .color(earrings.color))
        }
    }
}
