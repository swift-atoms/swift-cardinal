public import Carrier

extension RangeReplaceableCollection {

    @inlinable
    public mutating func reserveCapacity(_ minimumCapacity: some Carrier.`Protocol`<Cardinal>) {
        self.reserveCapacity(Int(bitPattern: minimumCapacity.underlying))
    }

    @inlinable
    public mutating func removeFirst(_ k: some Carrier.`Protocol`<Cardinal>) {
        self.removeFirst(Int(bitPattern: k.underlying))
    }
}
