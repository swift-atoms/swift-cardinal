public import Carrier_Protocol

extension Set {

    @inlinable
    public mutating func reserveCapacity(_ minimumCapacity: some Carrier::Carrier.`Protocol`<Cardinal::Cardinal>) {
        self.reserveCapacity(Int(bitPattern: minimumCapacity.underlying))
    }

    @inlinable
    public init(minimumCapacity: some Carrier::Carrier.`Protocol`<Cardinal::Cardinal>) {
        self.init(minimumCapacity: Int(bitPattern: minimumCapacity.underlying))
    }
}
