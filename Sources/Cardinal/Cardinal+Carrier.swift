public import Addition
public import Carrier
public import Property
public import Subtraction

extension Cardinal: Carrier::Carrier.`Protocol` {

    public typealias Underlying = Cardinal

}

extension Carrier::Carrier.`Protocol` where Underlying == Cardinal {

    @inlinable
    public var cardinal: Cardinal { underlying }

    @inlinable
    public var count: Cardinal { underlying }
}

extension Carrier::Carrier.`Protocol` where Underlying == Cardinal {

    @inlinable
    public static var zero: Self { Self(Cardinal(UInt.zero)) }

    @inlinable
    public static var one: Self { Self(Cardinal(1 as UInt)) }
}

extension Carrier::Carrier.`Protocol` where Underlying == Cardinal {

    @inlinable
    public static func + (lhs: Self, rhs: Self) -> Self {
        Self(lhs.underlying + rhs.underlying)
    }

    @inlinable
    public static func += (lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }

    @inlinable
    public var add: Property::Property<Addition, Self> { Property::Property(self) }

    @inlinable
    public var subtract: Property::Property<Subtraction, Self> { Property::Property(self) }
}

extension Property::Property
where Tag == Addition, Base: Carrier::Carrier.`Protocol`, Base.Underlying == Cardinal {

    @inlinable
    public func exact(_ other: Base) throws(Cardinal.Error) -> Base {
        try Base(base.cardinal.add.exact(other.cardinal))
    }

    @inlinable
    public func saturating(_ other: Base) -> Base {
        Base(base.cardinal.add.saturating(other.cardinal))
    }

    @inlinable
    public func callAsFunction(_ other: Base) throws(Cardinal.Error) -> Base {
        try exact(other)
    }
}

extension Property::Property
where Tag == Subtraction, Base: Carrier::Carrier.`Protocol`, Base.Underlying == Cardinal {

    @inlinable
    public func exact(_ other: Base) throws(Cardinal.Error) -> Base {
        try Base(base.cardinal.subtract.exact(other.cardinal))
    }

    @inlinable
    public func saturating(_ other: Base) -> Base {
        Base(base.cardinal.subtract.saturating(other.cardinal))
    }

    @inlinable
    public func callAsFunction(_ other: Base) throws(Cardinal.Error) -> Base {
        try exact(other)
    }
}
