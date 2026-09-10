public import Carrier

extension Swift.RangeReplaceableCollection {

    @inlinable
    public mutating func reserveCapacity(_ minimumCapacity: some Carrier::Carrier.`Protocol`<Cardinal>) {
        guard let capacity = try? Int(minimumCapacity.underlying) else {
            preconditionFailure("Capacity is not representable as Int")
        }
        self.reserveCapacity(capacity)
    }

    @inlinable
    public mutating func removeFirst(_ k: some Carrier::Carrier.`Protocol`<Cardinal>) {
        guard let length = try? Int(k.underlying) else {
            preconditionFailure("Count is not representable as Int")
        }
        self.removeFirst(length)
    }
}
