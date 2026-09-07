public import Carrier

extension Swift.OutputSpan where Element: ~Copyable {

    @unsafe
    @inlinable
    @_lifetime(borrow buffer)
    public init(
        buffer: UnsafeMutableBufferPointer<Element>,
        initializedCount: some Carrier::Carrier.`Protocol`<Cardinal>
    ) {
        guard let length = try? Int(initializedCount.underlying) else {
            preconditionFailure("Initialized count is not representable as Int")
        }
        unsafe self.init(
            buffer: buffer,
            initializedCount: length
        )
    }

    @inlinable
    @_lifetime(self: copy self)
    public mutating func removeLast(_ k: some Carrier::Carrier.`Protocol`<Cardinal>) {
        guard let length = try? Int(k.underlying) else {
            preconditionFailure("Count is not representable as Int")
        }
        removeLast(length)
    }
}

extension Swift.OutputSpan {

    @inlinable
    @_lifetime(self: copy self)
    public mutating func append(
        repeating repeatedValue: Element,
        count: some Carrier::Carrier.`Protocol`<Cardinal>
    ) {
        guard let length = try? Int(count.underlying) else {
            preconditionFailure("Count is not representable as Int")
        }
        append(repeating: repeatedValue, count: length)
    }
}
