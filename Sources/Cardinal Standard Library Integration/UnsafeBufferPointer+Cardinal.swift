public import Carrier

extension UnsafeBufferPointer where Element: ~Copyable {

    @inlinable
    public init(start: UnsafePointer<Element>?, count: some Carrier.`Protocol`<Cardinal>) {
        unsafe self.init(start: start, count: Int(bitPattern: count.underlying))
    }
}
