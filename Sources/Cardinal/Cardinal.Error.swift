extension Cardinal {

    public enum Error: Swift.Error, Hashable, Sendable {

        case overflow

        case underflow

        case negativeSource(Int)

        /// A signed-magnitude source below zero, including magnitudes above Int.max.
        case negativeMagnitude(UInt)
    }
}
