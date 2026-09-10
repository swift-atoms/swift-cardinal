public import Carrier

extension Swift.UnsafeMutableBufferPointer where Element: ~Copyable {

    @inlinable
    public init(start: UnsafeMutablePointer<Element>?, count: some Carrier::Carrier.`Protocol`<Cardinal>) {
        guard let length = try? Int(count.underlying) else {
            preconditionFailure("Count is not representable as Int")
        }
        unsafe self.init(start: start, count: length)
    }

    @inlinable
    public static func allocate(capacity: some Carrier::Carrier.`Protocol`<Cardinal>) -> Self {
        guard let length = try? Int(capacity.underlying) else {
            preconditionFailure("Capacity is not representable as Int")
        }
        return Self.allocate(capacity: length)
    }
}
