public import Cardinal_Add
public import Cardinal_Primitive
public import Property
public import Tagged

extension Tagged where Underlying == Cardinal, Tag: ~Copyable & ~Escapable {

    public enum Add {}
}

extension Tagged where Underlying == Cardinal, Tag: ~Copyable & ~Escapable {

    @inlinable
    public var add: Property<Add, Self> {
        Property(self)
    }
}

extension Property {

    @inlinable
    public func saturating<T: ~Copyable & ~Escapable>(_ other: Base) -> Base
    where
        Tag == Tagged<T, Cardinal>.Add,
        Base == Tagged<T, Cardinal>
    {
        base.map { $0.add.saturating(other.underlying) }
    }

    @inlinable
    public func exact<T: ~Copyable & ~Escapable>(_ other: Base) throws(Cardinal.Error) -> Base
    where
        Tag == Tagged<T, Cardinal>.Add,
        Base == Tagged<T, Cardinal>
    {
        try base.map { cardinal throws(Cardinal.Error) in try cardinal.add.exact(other.underlying) }
    }

    @inlinable
    public func callAsFunction<T: ~Copyable & ~Escapable>(
        _ other: Base
    ) throws(Cardinal.Error) -> Base
    where
        Tag == Tagged<T, Cardinal>.Add,
        Base == Tagged<T, Cardinal>
    {
        try self.exact(other)
    }
}
