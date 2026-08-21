public import Carrier_Primitives

extension Swift.Span where Element: ~Copyable {

    @unsafe
    @_lifetime(borrow start)
    @inlinable
    public init(
        _unsafeStart start: UnsafePointer<Element>,
        count: some Carrier.`Protocol`<Cardinal>
    ) {
        unsafe self.init(
            _unsafeStart: start,
            count: Int(bitPattern: count.underlying)
        )
    }

    @inlinable
    @_lifetime(copy self)
    public func extracting(first maxLength: some Carrier.`Protocol`<Cardinal>) -> Self {
        self.extracting(first: Int(bitPattern: maxLength.underlying))
    }

    @inlinable
    @_lifetime(copy self)
    public func extracting(droppingFirst k: some Carrier.`Protocol`<Cardinal>) -> Self {
        self.extracting(droppingFirst: Int(bitPattern: k.underlying))
    }

    @inlinable
    @_lifetime(copy self)
    public func extracting(last maxLength: some Carrier.`Protocol`<Cardinal>) -> Self {
        self.extracting(last: Int(bitPattern: maxLength.underlying))
    }

    @inlinable
    @_lifetime(copy self)
    public func extracting(droppingLast k: some Carrier.`Protocol`<Cardinal>) -> Self {
        self.extracting(droppingLast: Int(bitPattern: k.underlying))
    }
}
