public import Carrier_Protocol

extension String {

    @inlinable
    public init(repeating repeatedValue: String, count: some Carrier::Carrier.`Protocol`<Cardinal>) {
        self.init(repeating: repeatedValue, count: Int(bitPattern: count.underlying))
    }
}
