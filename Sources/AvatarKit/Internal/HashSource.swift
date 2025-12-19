import Foundation
import CryptoKit

/// SHA256 hash computation wrapper.
enum HashSource {
    /// Compute SHA256 hash of input string.
    /// - Parameter input: The string to hash.
    /// - Returns: Array of 32 bytes representing the SHA256 hash.
    static func sha256(_ input: String) -> [UInt8] {
        let data = Data(input.utf8)
        let digest = SHA256.hash(data: data)
        return Array(digest)
    }
}
