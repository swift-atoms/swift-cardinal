public import Cardinal_Error
public import Cardinal
public import Property

extension Cardinal::Cardinal {

    public enum Add {}

    @inlinable
    public var add: Property::Property<Add, Self> {
        Property::Property(self)
    }
}

extension Property::Property where Tag == Cardinal::Cardinal.Add, Base == Cardinal::Cardinal {

    @inlinable
    public func saturating(_ other: Base) -> Base {
        let (result, overflow) = base.rawValue.addingReportingOverflow(other.rawValue)
        if overflow {
            return Base(UInt.max)
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
