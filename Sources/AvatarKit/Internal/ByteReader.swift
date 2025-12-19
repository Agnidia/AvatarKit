/// Sequential byte consumption from a byte array.
struct ByteReader: Sendable {
    private let bytes: [UInt8]
    private var index: Int = 0

    /// Create a reader for the given bytes.
    /// - Parameter bytes: The bytes to read from.
    init(bytes: [UInt8]) {
        self.bytes = bytes
    }

    /// Read the next byte, returning 0 if exhausted.
    /// - Returns: The next byte or 0 if no more bytes available.
    mutating func next() -> UInt8 {
        guard index < bytes.count else { return 0 }
        defer { index += 1 }
        return bytes[index]
    }

    /// Read the next N bytes.
    /// - Parameter count: Number of bytes to read.
    /// - Returns: Array of bytes (may contain 0s if exhausted).
    mutating func nextBytes(_ count: Int) -> [UInt8] {
        var result: [UInt8] = []
        result.reserveCapacity(count)
        for _ in 0..<count {
            result.append(next())
        }
        return result
    }
}
