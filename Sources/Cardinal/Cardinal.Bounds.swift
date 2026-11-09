extension Cardinal {
    /// The smallest and largest counts a range of cardinals contains.
    public enum Bounds: Hashable, Sendable {
        /// The range contains no count.
        case empty

        /// The range contains every count from `minimum` through `maximum`.
        case bounded(minimum: Cardinal, maximum: Cardinal)

        /// The range contains every count from `minimum` upward.
        case unbounded(minimum: Cardinal)
    }
}
