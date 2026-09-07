public import Carrier

extension Swift.UnsafeRawBufferPointer {

    @inlinable
    public init(start: UnsafeRawPointer?, count: some Carrier::Carrier.`Protocol`<Cardinal>) {
        unsafe self.init(start: start, count: Int(bitPattern: count.underlying))
    }
}
