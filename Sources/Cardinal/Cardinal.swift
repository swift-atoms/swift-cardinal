public struct Cardinal {

    public let rawValue: UInt
}

extension Cardinal: Swift.Sendable {}

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
    public init(_ value: Swift.Int) throws(Self.Error) {
        guard value >= .zero else {
            throw .negativeSource(value)
        }
        self.init(UInt(value))
    }
}
