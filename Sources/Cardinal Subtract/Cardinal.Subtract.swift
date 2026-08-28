public import Cardinal_Carrier
public import Cardinal_Error
public import Cardinal
public import Property

extension Cardinal::Cardinal {

    public enum Subtract {}

    @inlinable
    public var subtract: Property::Property<Subtract, Self> {
        Property::Property(self)
    }
}

extension Property::Property where Tag == Cardinal::Cardinal.Subtract, Base == Cardinal::Cardinal {

    @inlinable
    public func saturating(_ other: Base) -> Base {
        if other >= base {
            return .zero
        }
        return Base(base.rawValue - other.rawValue)
    }

    @inlinable
    public func exact(_ other: Base) throws(Base.Error) -> Base {
        if other > base {
            throw .underflow
        }
        return Base(base.rawValue - other.rawValue)
    }
}
