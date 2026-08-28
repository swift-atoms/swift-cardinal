public import Carrier_Protocol

extension UnsafeMutableRawBufferPointer {

    @inlinable
    public init(start: UnsafeMutableRawPointer?, count: some Carrier::Carrier.`Protocol`<Cardinal::Cardinal>) {
        unsafe self.init(start: start, count: Int(bitPattern: count.underlying))
    }

    @inlinable
    public static func allocate(
        byteCount: some Carrier::Carrier.`Protocol`<Cardinal::Cardinal>,
        alignment: some Carrier::Carrier.`Protocol`<Cardinal::Cardinal>
    ) -> UnsafeMutableRawBufferPointer {
        Self.allocate(
            byteCount: Int(bitPattern: byteCount.underlying),
            alignment: Int(bitPattern: alignment.underlying)
        )
    }
}
