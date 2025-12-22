import SwiftUI
import AvatarKit

public struct ContentView: View {
    @State private var inputText = "john@example.com"
    @State private var avatarSize: CGFloat = 120

    public init() {}

    public var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                headerSection
                interactiveDemoSection

                Divider()

                sampleAvatarsSection

                Divider()

                faceDataSection
            }
            .padding(32)
        }
        .frame(minWidth: 600, minHeight: 500)
        .background(Color(white: 0.95))
    }

    // MARK: - Header

    private var headerSection: some View {
        VStack(spacing: 8) {
            Text("AvatarKit")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Deterministic 32×32 Pixel Art Avatars")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    // MARK: - Interactive Demo

    private var interactiveDemoSection: some View {
        VStack(spacing: 20) {
            Text("Interactive Demo")
                .font(.headline)

            HStack(spacing: 40) {
                VStack {
                    AvatarKit.avatar(for: inputText, size: avatarSize)
                        .shadow(color: .black.opacity(0.2), radius: 8, y: 4)

                    Text("Size: \(Int(avatarSize))pt")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Input String")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        TextField("Enter text...", text: $inputText)
                            .textFieldStyle(.roundedBorder)
                            .frame(width: 200)
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Size")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Slider(value: $avatarSize, in: 32...200, step: 8)
                            .frame(width: 200)
                    }
                }
            }
            .padding(24)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.1), radius: 4, y: 2)
        }
    }

    // MARK: - Sample Avatars

    private var sampleAvatarsSection: some View {
        VStack(spacing: 16) {
            Text("Sample Avatars")
                .font(.headline)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 16), count: 6), spacing: 16) {
                ForEach(sampleInputs, id: \.self) { input in
                    VStack(spacing: 4) {
                        AvatarKit.avatar(for: input, size: 64)
                            .shadow(color: .black.opacity(0.1), radius: 2, y: 1)

                        Text(input)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
        }
    }

    private var sampleInputs: [String] {
        [
            "alice", "bob", "charlie", "diana", "eve", "frank",
            "grace", "henry", "iris", "jack", "kate", "leo"
        ]
    }

    // MARK: - Face Data Inspector

    private var faceDataSection: some View {
        VStack(spacing: 16) {
            Text("Face Data Inspector")
                .font(.headline)

            let faceData = AvatarKit.faceData(for: inputText)

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 12) {
                dataCard("Face Shape", "\(faceData.faceShape)")
                dataCard("Skin Tone", "\(faceData.skinTone)")
                dataCard("Eyes", "\(faceData.eyes)")
                dataCard("Eye Color", "\(faceData.eyeColor)")
                dataCard("Eyebrows", "\(faceData.eyebrows)")
                dataCard("Nose", "\(faceData.nose)")
                dataCard("Mouth", "\(faceData.mouth)")
                dataCard("Hair Style", "\(faceData.hairStyle)")
                dataCard("Hair Color", "\(faceData.hairColor)")
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)

            if faceData.accessories.glasses != nil ||
               faceData.accessories.facialHair != nil ||
               faceData.accessories.earrings != nil {
                HStack(spacing: 12) {
                    if let glasses = faceData.accessories.glasses {
                        accessoryBadge("Glasses: \(glasses)")
                    }
                    if let facialHair = faceData.accessories.facialHair {
                        accessoryBadge("Facial Hair: \(facialHair)")
                    }
                    if let earrings = faceData.accessories.earrings {
                        accessoryBadge("Earrings: \(earrings)")
                    }
                }
            } else {
                Text("No accessories")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }

    private func dataCard(_ title: String, _ value: String) -> some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.caption2)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.caption)
                .fontWeight(.medium)
        }
        .padding(8)
        .frame(maxWidth: .infinity)
        .background(Color(white: 0.97))
        .cornerRadius(8)
    }

    private func accessoryBadge(_ text: String) -> some View {
        Text(text)
            .font(.caption)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.blue.opacity(0.1))
            .foregroundStyle(.blue)
            .cornerRadius(4)
    }
}

#Preview {
    ContentView()
}
