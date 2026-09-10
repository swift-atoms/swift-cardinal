public import Carrier

extension Swift.MutableRawSpan {

    @unsafe
    @_lifetime(borrow pointer)
    @inlinable
    public init(
        _unsafeStart pointer: UnsafeMutableRawPointer,
        byteCount: some Carrier::Carrier.`Protocol`<Cardinal>
    ) {
        guard let length = try? Int(byteCount.underlying) else {
            preconditionFailure("Byte count is not representable as Int")
        }
        unsafe self.init(
            _unsafeStart: pointer,
            byteCount: length
        )
    }
}
