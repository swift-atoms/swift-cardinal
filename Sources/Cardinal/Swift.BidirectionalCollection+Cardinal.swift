public import Carrier

extension Swift.BidirectionalCollection where Self: RangeReplaceableCollection {

    @inlinable
    public mutating func removeLast(_ k: some Carrier::Carrier.`Protocol`<Cardinal>) {
        self.removeLast(Int(bitPattern: k.underlying))
    }
}
