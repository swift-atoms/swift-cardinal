public import Carrier_Protocol

extension Swift.OutputSpan where Element: ~Copyable {

    @unsafe
    @inlinable
    @_lifetime(borrow buffer)
    public init(
        buffer: UnsafeMutableBufferPointer<Element>,
        initializedCount: some Carrier::Carrier.`Protocol`<Cardinal::Cardinal>
    ) {
        unsafe self.init(
            buffer: buffer,
            initializedCount: Int(bitPattern: initializedCount.underlying)
        )
    }

    @inlinable
    @_lifetime(self: copy self)
    public mutating func removeLast(_ k: some Carrier::Carrier.`Protocol`<Cardinal::Cardinal>) {
        removeLast(Int(bitPattern: k.underlying))
    }
}

extension Swift.OutputSpan {

    @inlinable
    @_lifetime(self: copy self)
    public mutating func append(
        repeating repeatedValue: Element,
        count: some Carrier::Carrier.`Protocol`<Cardinal::Cardinal>
    ) {
        append(repeating: repeatedValue, count: Int(bitPattern: count.underlying))
    }
}
