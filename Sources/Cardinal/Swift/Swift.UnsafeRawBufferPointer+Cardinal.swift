public import Carrier

extension Swift.UnsafeRawBufferPointer {

    @inlinable
    public init(start: UnsafeRawPointer?, count: some Carrier::Carrier.`Protocol`<Cardinal>) {
        guard let length = try? Int(count.underlying) else {
            preconditionFailure("Count is not representable as Int")
        }
        unsafe self.init(start: start, count: length)
    }
}
