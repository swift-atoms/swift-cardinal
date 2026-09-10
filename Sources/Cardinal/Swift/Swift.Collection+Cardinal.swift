public import Carrier

extension Swift.Collection {

    @inlinable
    public __consuming func prefix(_ maxLength: some Carrier::Carrier.`Protocol`<Cardinal>) -> SubSequence {
        guard let length = try? Int(maxLength.underlying) else {
            preconditionFailure("Length is not representable as Int")
        }
        return self.prefix(length)
    }

    @inlinable
    public __consuming func suffix(_ maxLength: some Carrier::Carrier.`Protocol`<Cardinal>) -> SubSequence {
        guard let length = try? Int(maxLength.underlying) else {
            preconditionFailure("Length is not representable as Int")
        }
        return self.suffix(length)
    }

    @inlinable
    public __consuming func dropFirst(_ k: some Carrier::Carrier.`Protocol`<Cardinal>) -> SubSequence {
        guard let length = try? Int(k.underlying) else {
            preconditionFailure("Count is not representable as Int")
        }
        return self.dropFirst(length)
    }

    @inlinable
    public __consuming func dropLast(_ k: some Carrier::Carrier.`Protocol`<Cardinal>) -> SubSequence {
        guard let length = try? Int(k.underlying) else {
            preconditionFailure("Count is not representable as Int")
        }
        return self.dropLast(length)
    }
}
