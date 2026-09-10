public import Carrier

extension Swift.String {

    @inlinable
    public init(repeating repeatedValue: String, count: some Carrier::Carrier.`Protocol`<Cardinal>) {
        guard let length = try? Int(count.underlying) else {
            preconditionFailure("Count is not representable as Int")
        }
        self.init(repeating: repeatedValue, count: length)
    }
}
