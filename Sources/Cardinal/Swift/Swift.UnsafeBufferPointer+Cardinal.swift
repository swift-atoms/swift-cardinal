public import Carrier

extension Swift.UnsafeBufferPointer where Element: ~Copyable {

    @inlinable
    public init(start: UnsafePointer<Element>?, count: some Carrier::Carrier.`Protocol`<Cardinal>) {
        guard let length = try? Int(count.underlying) else {
            preconditionFailure("Count is not representable as Int")
        }
        unsafe self.init(start: start, count: length)
    }
}
