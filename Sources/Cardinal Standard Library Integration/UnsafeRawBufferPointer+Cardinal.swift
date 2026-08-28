public import Carrier

extension UnsafeRawBufferPointer {

    @inlinable
    public init(start: UnsafeRawPointer?, count: some Carrier.`Protocol`<Cardinal>) {
        unsafe self.init(start: start, count: Int(bitPattern: count.underlying))
    }
}
