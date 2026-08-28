public import Cardinal
public import Carrier_Protocol

extension Cardinal::Cardinal: Carrier::Carrier.`Protocol` {

    public typealias Underlying = Cardinal::Cardinal

}

extension Carrier::Carrier.`Protocol` where Underlying == Cardinal::Cardinal {

    @inlinable
    public var cardinal: Cardinal::Cardinal { underlying }

    @inlinable
    public var count: Cardinal::Cardinal { underlying }
}

extension Carrier::Carrier.`Protocol` where Underlying == Cardinal::Cardinal {

    @inlinable
    public static var zero: Self { Self(Cardinal::Cardinal(UInt.zero)) }

    @inlinable
    public static var one: Self { Self(Cardinal::Cardinal(1 as UInt)) }
}

extension Carrier::Carrier.`Protocol` where Underlying == Cardinal::Cardinal {

    @inlinable
    public static func + (lhs: Self, rhs: Self) -> Self {
        Self(lhs.underlying + rhs.underlying)
    }

    @inlinable
    public static func += (lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }
}
