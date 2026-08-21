public import Carrier_Primitives

extension String {

    @inlinable
    public init(repeating repeatedValue: String, count: some Carrier.`Protocol`<Cardinal>) {
        self.init(repeating: repeatedValue, count: Int(bitPattern: count.underlying))
    }
}
