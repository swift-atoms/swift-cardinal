public import Carrier_Protocol

extension UnsafeBufferPointer where Element: ~Copyable {

    @inlinable
    public init(start: UnsafePointer<Element>?, count: some Carrier::Carrier.`Protocol`<Cardinal::Cardinal>) {
        unsafe self.init(start: start, count: Int(bitPattern: count.underlying))
    }
}
