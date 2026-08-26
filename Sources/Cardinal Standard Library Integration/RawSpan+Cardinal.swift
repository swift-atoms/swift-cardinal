public import Carrier

extension RawSpan {

    @unsafe
    @_lifetime(borrow pointer)
    @inlinable
    public init(
        _unsafeStart pointer: UnsafeRawPointer,
        byteCount: some Carrier.`Protocol`<Cardinal>
    ) {
        unsafe self.init(
            _unsafeStart: pointer,
            byteCount: Int(bitPattern: byteCount.underlying)
        )
    }
}
