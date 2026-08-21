public import Carrier_Primitives

extension MutableRawSpan {

    @unsafe
    @_lifetime(borrow pointer)
    @inlinable
    public init(
        _unsafeStart pointer: UnsafeMutableRawPointer,
        byteCount: some Carrier.`Protocol`<Cardinal>
    ) {
        unsafe self.init(
            _unsafeStart: pointer,
            byteCount: Int(bitPattern: byteCount.underlying)
        )
    }
}
