public import Cardinal_Error
public import Cardinal_Primitive
public import Cardinal_Subtract
public import Property
public import Tagged

extension Tagged where Underlying == Cardinal, Tag: ~Copyable & ~Escapable {

    public enum Subtract {}
}

extension Tagged where Underlying == Cardinal, Tag: ~Copyable & ~Escapable {

    @inlinable
    public var subtract: Property<Subtract, Self> {
        Property(self)
    }
}

extension Property {

    @inlinable
    public func saturating<T: ~Copyable & ~Escapable>(_ other: Base) -> Base
    where
        Tag == Tagged<T, Cardinal>.Subtract,
        Base == Tagged<T, Cardinal>
    {
        base.map { $0.subtract.saturating(other.underlying) }
    }

    @inlinable
    public func exact<T: ~Copyable & ~Escapable>(_ other: Base) throws(Cardinal.Error) -> Base
    where
        Tag == Tagged<T, Cardinal>.Subtract,
        Base == Tagged<T, Cardinal>
    {
        try base.map { cardinal throws(Cardinal.Error) in
            try cardinal.subtract.exact(other.underlying)
        }
    }

    @inlinable
    public func callAsFunction<T: ~Copyable & ~Escapable>(
        _ other: Base
    ) throws(Cardinal.Error) -> Base
    where
        Tag == Tagged<T, Cardinal>.Subtract,
        Base == Tagged<T, Cardinal>
    {
        try self.exact(other)
    }
}
