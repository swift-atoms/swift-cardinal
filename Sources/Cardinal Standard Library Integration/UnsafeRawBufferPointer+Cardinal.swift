public import Carrier_Protocol

extension UnsafeRawBufferPointer {

    @inlinable
    public init(start: UnsafeRawPointer?, count: some Carrier::Carrier.`Protocol`<Cardinal::Cardinal>) {
        unsafe self.init(start: start, count: Int(bitPattern: count.underlying))
    }
}
