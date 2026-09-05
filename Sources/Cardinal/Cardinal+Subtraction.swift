public import Property
public import Subtraction

extension Cardinal {
    @inlinable
    public var subtract: Property::Property<Subtraction, Self> {
        Property::Property(self)
    }
}

extension Property::Property where Tag == Subtraction, Base == Cardinal {

    @inlinable
    public func saturating(_ other: Base) -> Base {
        Base(Subtraction.saturating(base.rawValue, other.rawValue))
    }

    @inlinable
    public func exact(_ other: Base) throws(Base.Error) -> Base {
        do { return Base(try Subtraction.exact(base.rawValue, other.rawValue)) }
        catch { throw .underflow }
    }
}
