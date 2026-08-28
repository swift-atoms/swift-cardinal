public import Carrier_Protocol

extension RangeReplaceableCollection {

    @inlinable
    public mutating func reserveCapacity(_ minimumCapacity: some Carrier::Carrier.`Protocol`<Cardinal::Cardinal>) {
        self.reserveCapacity(Int(bitPattern: minimumCapacity.underlying))
    }

    @inlinable
    public mutating func removeFirst(_ k: some Carrier::Carrier.`Protocol`<Cardinal::Cardinal>) {
        self.removeFirst(Int(bitPattern: k.underlying))
    }
}
