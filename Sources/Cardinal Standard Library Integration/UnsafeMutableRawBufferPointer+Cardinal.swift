public import Carrier

extension UnsafeMutableRawBufferPointer {

    @inlinable
    public init(start: UnsafeMutableRawPointer?, count: some Carrier.`Protocol`<Cardinal>) {
        unsafe self.init(start: start, count: Int(bitPattern: count.underlying))
    }

    @inlinable
    public static func allocate(
        byteCount: some Carrier.`Protocol`<Cardinal>,
        alignment: some Carrier.`Protocol`<Cardinal>
    ) -> UnsafeMutableRawBufferPointer {
        Self.allocate(
            byteCount: Int(bitPattern: byteCount.underlying),
            alignment: Int(bitPattern: alignment.underlying)
        )
    }
}
