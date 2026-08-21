public import Cardinal_Primitive
public import Carrier_Primitives

extension Cardinal: Carrier.`Protocol` {

    public typealias Underlying = Cardinal

}

extension Carrier.`Protocol` where Underlying == Cardinal {

    @inlinable
    public var cardinal: Cardinal { underlying }

    @inlinable
    public var count: Cardinal { underlying }
}

extension Carrier.`Protocol` where Underlying == Cardinal {

    @inlinable
    public static var zero: Self { Self(Cardinal(UInt.zero)) }

    @inlinable
    public static var one: Self { Self(Cardinal(1 as UInt)) }
}

extension Carrier.`Protocol` where Underlying == Cardinal {

    @inlinable
    public static func + (lhs: Self, rhs: Self) -> Self {
        Self(lhs.underlying + rhs.underlying)
    }

    @inlinable
    public static func += (lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }
}
