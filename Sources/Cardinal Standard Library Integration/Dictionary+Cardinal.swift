public import Carrier_Protocol

extension Dictionary {

    @inlinable
    public mutating func reserveCapacity(_ minimumCapacity: some Carrier::Carrier.`Protocol`<Cardinal>) {
        self.reserveCapacity(Int(bitPattern: minimumCapacity.underlying))
    }

    @inlinable
    public init(minimumCapacity: some Carrier::Carrier.`Protocol`<Cardinal>) {
        self.init(minimumCapacity: Int(bitPattern: minimumCapacity.underlying))
    }
}
