public import Carrier_Protocol

extension MutableRawSpan {

    @unsafe
    @_lifetime(borrow pointer)
    @inlinable
    public init(
        _unsafeStart pointer: UnsafeMutableRawPointer,
        byteCount: some Carrier::Carrier.`Protocol`<Cardinal::Cardinal>
    ) {
        unsafe self.init(
            _unsafeStart: pointer,
            byteCount: Int(bitPattern: byteCount.underlying)
        )
    }
}
