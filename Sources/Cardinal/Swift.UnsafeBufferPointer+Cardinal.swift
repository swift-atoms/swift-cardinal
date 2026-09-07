public import Carrier

extension Swift.UnsafeBufferPointer where Element: ~Copyable {

    @inlinable
    public init(start: UnsafePointer<Element>?, count: some Carrier::Carrier.`Protocol`<Cardinal>) {
        unsafe self.init(start: start, count: Int(bitPattern: count.underlying))
    }
}
