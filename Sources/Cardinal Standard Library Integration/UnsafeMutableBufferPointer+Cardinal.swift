public import Carrier_Protocol

extension UnsafeMutableBufferPointer where Element: ~Copyable {

    @inlinable
    public init(start: UnsafeMutablePointer<Element>?, count: some Carrier::Carrier.`Protocol`<Cardinal::Cardinal>) {
        unsafe self.init(start: start, count: Int(bitPattern: count.underlying))
    }

    @inlinable
    public static func allocate(capacity: some Carrier::Carrier.`Protocol`<Cardinal::Cardinal>) -> Self {
        Self.allocate(capacity: Int(bitPattern: capacity.underlying))
    }
}
