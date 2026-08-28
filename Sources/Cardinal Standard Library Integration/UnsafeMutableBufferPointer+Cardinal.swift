public import Carrier

extension UnsafeMutableBufferPointer where Element: ~Copyable {

    @inlinable
    public init(start: UnsafeMutablePointer<Element>?, count: some Carrier.`Protocol`<Cardinal>) {
        unsafe self.init(start: start, count: Int(bitPattern: count.underlying))
    }

    @inlinable
    public static func allocate(capacity: some Carrier.`Protocol`<Cardinal>) -> Self {
        Self.allocate(capacity: Int(bitPattern: capacity.underlying))
    }
}
