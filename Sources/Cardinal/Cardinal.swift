public struct Cardinal {

    public let rawValue: UInt
}

extension Cardinal: Swift::Sendable {}

extension Cardinal {

    @inlinable
    public init(_ value: UInt) {
        self.rawValue = value
    }
}

extension Cardinal {

    @inlinable
    public static var zero: Cardinal { Cardinal(UInt.zero) }

    @inlinable
    public static var one: Cardinal { Cardinal(UInt(1)) }

    @inlinable
    public static var max: Cardinal { Cardinal(UInt.max) }
}

extension Cardinal {

    @inlinable
    public static func + (lhs: Self, rhs: Self) -> Self {
        let result = lhs.rawValue.addingReportingOverflow(rhs.rawValue)
        precondition(!result.overflow, "Cardinal overflow in addition")
        return Cardinal(result.partialValue)
    }

    @inlinable
    public static func += (lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }

    @inlinable
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue == rhs.rawValue
    }

    @inlinable
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue < rhs.rawValue
    }

    @inlinable
    public static func <= (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue <= rhs.rawValue
    }

    @inlinable
    public static func > (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue > rhs.rawValue
    }

    @inlinable
    public static func >= (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue >= rhs.rawValue
    }
}

extension Cardinal {
    @inlinable
    public init<T: UnsignedInteger>(_ value: T) {
        self.init(UInt(value))
    }
}

extension Cardinal {
    @inlinable
    public init(_ value: Swift::Int) throws(Self.Error) {
        guard value >= .zero else {
            throw .negativeSource(value)
        }
        self.init(UInt(value))
    }
}

#if Algebra
    public import Algebra

    extension Cardinal {

        @inlinable
        public static var monoid: Algebra.Monoid<Self>.Commutative {
            .init(
                monoid: .init(
                    identity: Cardinal(UInt.zero),
                    combining: { $0 + $1 }
                )
            )
        }
    }
#endif

#if SYNCHRONIZATION_AVAILABLE
    import Synchronization
#endif

extension Cardinal: Swift::CustomStringConvertible {

    public var description: String { rawValue.description }
}

#if SYNCHRONIZATION_AVAILABLE
    import Synchronization
#endif

extension Cardinal: Swift::ExpressibleByIntegerLiteral {

    @_disfavoredOverload
    @inlinable
    public init(integerLiteral value: UInt) {
        self.init(value)
    }
}

#if SYNCHRONIZATION_AVAILABLE
    import Synchronization
#endif

extension Cardinal: Swift::Hashable, Swift::Comparable {

    @inlinable
    public borrowing func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}
