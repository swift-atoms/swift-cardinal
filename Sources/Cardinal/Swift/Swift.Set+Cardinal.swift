public import Carrier

extension Swift.Set {

    @inlinable
    public mutating func reserveCapacity(_ minimumCapacity: some Carrier::Carrier.`Protocol`<Cardinal>) {
        guard let capacity = try? Int(minimumCapacity.underlying) else {
            preconditionFailure("Capacity is not representable as Int")
        }
        self.reserveCapacity(capacity)
    }

    @inlinable
    public init(minimumCapacity: some Carrier::Carrier.`Protocol`<Cardinal>) {
        guard let capacity = try? Int(minimumCapacity.underlying) else {
            preconditionFailure("Capacity is not representable as Int")
        }
        self.init(minimumCapacity: capacity)
    }
}
