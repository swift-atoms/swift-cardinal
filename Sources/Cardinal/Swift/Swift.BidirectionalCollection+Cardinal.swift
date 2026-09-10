public import Carrier

extension Swift.BidirectionalCollection where Self: RangeReplaceableCollection {

    @inlinable
    public mutating func removeLast(_ k: some Carrier::Carrier.`Protocol`<Cardinal>) {
        guard let length = try? Int(k.underlying) else {
            preconditionFailure("Count is not representable as Int")
        }
        self.removeLast(length)
    }
}
