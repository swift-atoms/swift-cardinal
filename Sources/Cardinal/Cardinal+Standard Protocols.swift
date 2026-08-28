extension Cardinal: Hashable, Comparable {

    @inlinable
    public borrowing func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension Cardinal: CustomStringConvertible {

    public var description: String { rawValue.description }
}

extension Cardinal: ExpressibleByIntegerLiteral {

    @_disfavoredOverload
    @inlinable
    public init(integerLiteral value: UInt) {
        self.init(value)
    }
}

extension Cardinal {

    @inlinable
    public init<T: UnsignedInteger>(_ value: T) {
        self.init(UInt(value))
    }
}

#if SYNCHRONIZATION_AVAILABLE
    public import Synchronization

    extension Cardinal: AtomicRepresentable {

        public typealias AtomicRepresentation = UInt.AtomicRepresentation

        @inlinable
        public static func encodeAtomicRepresentation(
            _ value: consuming Cardinal
        ) -> AtomicRepresentation {
            UInt.encodeAtomicRepresentation(value.rawValue)
        }

        @inlinable
        public static func decodeAtomicRepresentation(
            _ representation: consuming AtomicRepresentation
        ) -> Cardinal {
            Cardinal(UInt.decodeAtomicRepresentation(representation))
        }
    }
#endif
