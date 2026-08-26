public import Cardinal_Carrier
public import Cardinal_Error
public import Cardinal_Primitive
public import Property

extension Cardinal {

    public enum Subtract {}

    @inlinable
    public var subtract: Property<Subtract, Self> {
        Property(self)
    }
}

extension Property where Tag == Cardinal.Subtract, Base == Cardinal {

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
