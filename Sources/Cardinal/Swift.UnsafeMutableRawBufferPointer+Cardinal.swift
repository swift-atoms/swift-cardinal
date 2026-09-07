public import Carrier

extension Swift.UnsafeMutableRawBufferPointer {

    @inlinable
    public init(start: UnsafeMutableRawPointer?, count: some Carrier::Carrier.`Protocol`<Cardinal>) {
        guard let length = try? Int(count.underlying) else {
            preconditionFailure("Count is not representable as Int")
        }
        unsafe self.init(start: start, count: length)
    }

    @inlinable
    public static func allocate(
        byteCount: some Carrier::Carrier.`Protocol`<Cardinal>,
        alignment: some Carrier::Carrier.`Protocol`<Cardinal>
    ) -> UnsafeMutableRawBufferPointer {
        guard let length = try? Int(byteCount.underlying) else {
            preconditionFailure("Byte count is not representable as Int")
        }
        guard let byteAlignment = try? Int(alignment.underlying) else {
            preconditionFailure("Alignment is not representable as Int")
        }
        return Self.allocate(
            byteCount: length,
            alignment: byteAlignment
        )
    }
}
