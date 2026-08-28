public import Cardinal_Error
public import Cardinal_Primitive
public import Property

extension Cardinal {

    public enum Add {}

    @inlinable
    public var add: Property<Add, Self> {
        Property(self)
    }
}

extension Property where Tag == Cardinal.Add, Base == Cardinal {

    @inlinable
    public func saturating(_ other: Base) -> Base {
        let (result, overflow) = base.rawValue.addingReportingOverflow(other.rawValue)
        if overflow {
            return Base(.max)
        }
        return Base(result)
    }

    @inlinable
    public func exact(_ other: Base) throws(Base.Error) -> Base {
        let (result, overflow) = base.rawValue.addingReportingOverflow(other.rawValue)
        if overflow {
            throw .overflow
        }
        return Base(result)
    }
}
