public import Cardinal_Error
public import Cardinal
public import Cardinal_Subtract
public import Property
public import Tagged

extension Tagged::Tagged where Underlying == Cardinal::Cardinal, Tag: ~Copyable & ~Escapable {

    public enum Subtract {}
}

extension Tagged::Tagged where Underlying == Cardinal::Cardinal, Tag: ~Copyable & ~Escapable {

    @inlinable
    public var subtract: Property::Property<Subtract, Self> {
        Property::Property(self)
    }
}

extension Property::Property {

    @inlinable
    public func saturating<T: ~Copyable & ~Escapable>(_ other: Base) -> Base
    where
        Tag == Tagged::Tagged<T, Cardinal::Cardinal>.Subtract,
        Base == Tagged::Tagged<T, Cardinal::Cardinal>
    {
        base.map { $0.subtract.saturating(other.underlying) }
    }

    @inlinable
    public func exact<T: ~Copyable & ~Escapable>(_ other: Base) throws(Cardinal::Cardinal.Error) -> Base
    where
        Tag == Tagged::Tagged<T, Cardinal::Cardinal>.Subtract,
        Base == Tagged::Tagged<T, Cardinal::Cardinal>
    {
        try base.map { cardinal throws(Cardinal::Cardinal.Error) in
            try cardinal.subtract.exact(other.underlying)
        }
    }

    @inlinable
    public func callAsFunction<T: ~Copyable & ~Escapable>(
        _ other: Base
    ) throws(Cardinal::Cardinal.Error) -> Base
    where
        Tag == Tagged::Tagged<T, Cardinal::Cardinal>.Subtract,
        Base == Tagged::Tagged<T, Cardinal::Cardinal>
    {
        try self.exact(other)
    }
}
