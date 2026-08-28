public import Cardinal_Add
public import Cardinal
public import Property
public import Tagged

extension Tagged::Tagged where Underlying == Cardinal::Cardinal, Tag: ~Copyable & ~Escapable {

    public enum Add {}
}

extension Tagged::Tagged where Underlying == Cardinal::Cardinal, Tag: ~Copyable & ~Escapable {

    @inlinable
    public var add: Property::Property<Add, Self> {
        Property::Property(self)
    }
}

extension Property::Property {

    @inlinable
    public func saturating<T: ~Copyable & ~Escapable>(_ other: Base) -> Base
    where
        Tag == Tagged::Tagged<T, Cardinal::Cardinal>.Add,
        Base == Tagged::Tagged<T, Cardinal::Cardinal>
    {
        base.map { $0.add.saturating(other.underlying) }
    }

    @inlinable
    public func exact<T: ~Copyable & ~Escapable>(_ other: Base) throws(Cardinal::Cardinal.Error) -> Base
    where
        Tag == Tagged::Tagged<T, Cardinal::Cardinal>.Add,
        Base == Tagged::Tagged<T, Cardinal::Cardinal>
    {
        try base.map { cardinal throws(Cardinal::Cardinal.Error) in try cardinal.add.exact(other.underlying) }
    }

    @inlinable
    public func callAsFunction<T: ~Copyable & ~Escapable>(
        _ other: Base
    ) throws(Cardinal::Cardinal.Error) -> Base
    where
        Tag == Tagged::Tagged<T, Cardinal::Cardinal>.Add,
        Base == Tagged::Tagged<T, Cardinal::Cardinal>
    {
        try self.exact(other)
    }
}
