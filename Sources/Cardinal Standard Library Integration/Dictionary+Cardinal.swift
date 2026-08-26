public import Carrier

extension Dictionary {

    @inlinable
    public mutating func reserveCapacity(_ minimumCapacity: some Carrier.`Protocol`<Cardinal>) {
        self.reserveCapacity(Int(bitPattern: minimumCapacity.underlying))
    }

    @inlinable
    public init(minimumCapacity: some Carrier.`Protocol`<Cardinal>) {
        self.init(minimumCapacity: Int(bitPattern: minimumCapacity.underlying))
    }
}
