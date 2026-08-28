public import Carrier

extension BidirectionalCollection where Self: RangeReplaceableCollection {

    @inlinable
    public mutating func removeLast(_ k: some Carrier.`Protocol`<Cardinal>) {
        self.removeLast(Int(bitPattern: k.underlying))
    }
}
