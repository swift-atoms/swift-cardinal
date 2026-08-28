public struct Cardinal {

    public let rawValue: UInt
}

extension Cardinal: Sendable {}

extension Cardinal {

    @inlinable
    public init(_ value: UInt) {
        self.rawValue = value
    }
}

extension Cardinal {

    @inlinable
    public static var max: Cardinal { Cardinal(UInt.max) }
}

extension Cardinal {

    @inlinable
    public static func + (lhs: Self, rhs: Self) -> Self {
        let (result, overflow) = lhs.rawValue.addingReportingOverflow(rhs.rawValue)
        precondition(!overflow, "Cardinal overflow in addition")
        return Self(result)
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
