public import Addition
public import Property

extension Cardinal {
    @inlinable
    public var add: Property<Addition, Self> { Property(self) }
}

extension Property where Tag == Addition, Base == Cardinal {
    @inlinable
    public func exact(_ other: Base) throws(Cardinal.Error) -> Base {
        do { return Cardinal(try Addition.exact(base.rawValue, other.rawValue)) }
        catch { throw .overflow }
    }

    @inlinable
    public func saturating(_ other: Base) -> Base {
        Cardinal(Addition.saturating(base.rawValue, other.rawValue))
    }
}
