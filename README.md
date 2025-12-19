# AvatarKit

A Swift package for generating unique, deterministic face avatars from input strings. Perfect for user profiles, identicons, and anywhere you need consistent visual identification.

[![Swift 6.0](https://img.shields.io/badge/Swift-6.0-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/Platforms-macOS%20|%20iOS%20|%20tvOS%20|%20watchOS%20|%20visionOS-blue.svg)](https://developer.apple.com)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## Features

- **Deterministic**: Same input always produces the same avatar
- **Unique**: Different inputs produce visually distinct faces
- **Swift 6 Ready**: Full Sendable compliance and modern concurrency support
- **Cross-Platform**: Works on all Apple platforms
- **Zero Dependencies**: Pure Swift implementation
- **Multiple Styles**: Cartoon, Minimalist, Pixel, and Geometric

## Installation

### Swift Package Manager

Add AvatarKit to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/AvatarKit.git", from: "1.0.0")
]
```

Or in Xcode: File → Add Package Dependencies → Enter the repository URL.

## Quick Start

```swift
import AvatarKit
import SwiftUI

struct ContentView: View {
    var body: some View {
        // Generate an avatar from any string
        AvatarKit.avatar(for: "john@example.com")
    }
}
```

## Usage

### Basic Avatar Generation

```swift
// Default cartoon style, 64pt size
let avatar = AvatarKit.avatar(for: "username")

// Specific style
let minimalist = AvatarKit.avatar(for: "username", style: .minimalist)

// Custom size
let large = AvatarKit.avatar(for: "username", size: 128)

// Full customization
let custom = AvatarKit.avatar(for: "username", style: .geometric, size: 96)
```

### Available Styles

| Style | Description |
|-------|-------------|
| `.cartoon` | Colorful, rounded, expressive (default) |
| `.minimalist` | Simple lines, limited colors, clean |
| `.pixel` | Retro pixel art (32×32 grid) |
| `.geometric` | Abstract shapes, flat colors |

### Batch Generation

```swift
// Generate multiple avatars at once
let avatars = AvatarKit.avatars(
    for: ["user1", "user2", "user3"],
    style: .cartoon,
    size: 48
)
```

### Working with Face Data

For custom rendering or analysis:

```swift
// Get raw face data
let faceData = AvatarKit.faceData(for: "username")

print(faceData.faceShape)    // .oval, .round, .square, etc.
print(faceData.skinTone)     // .porcelain, .honey, .espresso, etc.
print(faceData.hairStyle)    // .short, .long, .curly, etc.
print(faceData.accessories)  // glasses, facial hair, earrings
```

### Reusable Generator

For generating many avatars with the same style:

```swift
let generator = AvatarKit.generator(style: .minimalist)

let avatar1 = generator.avatar(for: "user1")
let avatar2 = generator.avatar(for: "user2")
let avatar3 = generator.avatar(for: "user3")
```

## Face Components

Each avatar is composed of:

| Component | Variations |
|-----------|------------|
| Face Shape | Oval, Round, Square, Heart, Oblong, Diamond |
| Skin Tone | 8 natural tones |
| Eyes | 8 shapes including wink |
| Eye Color | 8 colors |
| Eyebrows | 6 styles |
| Nose | 6 shapes |
| Mouth | 8 expressions |
| Hair Style | 12 styles including bald |
| Hair Color | 10 colors |
| Accessories | Glasses, Facial Hair, Earrings |

## How It Works

AvatarKit uses SHA256 hashing to convert input strings into deterministic face attributes:

1. **Hash**: Input string → SHA256 → 32 bytes
2. **Select**: Each byte selects a face component via modulo
3. **Render**: Components are composed into a SwiftUI Canvas view

This ensures:
- Same input → Same avatar (always)
- Different inputs → Different avatars (statistically)
- No storage required (computed on demand)

## Platform Support

| Platform | Minimum Version |
|----------|-----------------|
| macOS | 12.0+ |
| iOS | 15.0+ |
| tvOS | 15.0+ |
| watchOS | 8.0+ |
| visionOS | 1.0+ |

## Thread Safety

All types in AvatarKit are `Sendable` and safe to use from any thread or actor:

```swift
// Safe to use in async contexts
Task {
    let faceData = AvatarKit.faceData(for: "username")
    await MainActor.run {
        let avatar = AvatarKit.avatar(for: "username")
        // Use avatar in UI
    }
}
```

## Examples

### Profile View

```swift
struct ProfileView: View {
    let userId: String

    var body: some View {
        VStack {
            AvatarKit.avatar(for: userId, size: 120)
                .clipShape(Circle())
                .shadow(radius: 4)

            Text(userId)
                .font(.headline)
        }
    }
}
```

### User List

```swift
struct UserListView: View {
    let users: [String]

    var body: some View {
        List(users, id: \.self) { user in
            HStack {
                AvatarKit.avatar(for: user, style: .minimalist, size: 40)
                Text(user)
            }
        }
    }
}
```

### Style Showcase

```swift
struct StyleShowcase: View {
    let input = "demo@example.com"

    var body: some View {
        HStack(spacing: 20) {
            ForEach(AvatarStyle.allCases, id: \.self) { style in
                VStack {
                    AvatarKit.avatar(for: input, style: style, size: 64)
                    Text(style.rawValue.capitalized)
                        .font(.caption)
                }
            }
        }
    }
}
```

## Example App

A full-featured example app is included in the `Example/` directory.

### Running the Example

Open the Xcode workspace and run:

```bash
open Example/AvatarKitExample.xcworkspace
```

Then press `Cmd+R` to build and run the macOS app.

The example app demonstrates:
- Interactive avatar generation with live preview
- All 4 visual styles side by side
- Size adjustment slider
- Sample avatar grid
- Face data inspector showing all components

## License

MIT License. See [LICENSE](LICENSE) for details.

## Credits

Inspired by:
- [Pagan](https://github.com/daboth/pagan) - Python avatar generator
- [NicknameKit](https://github.com/IGRSoft/NicknameKit) - Architecture patterns
