public import Carrier_Primitives

extension Swift.MutableSpan where Element: ~Copyable {

    @unsafe
    @_lifetime(borrow start)
    @inlinable
    public init(
        _unsafeStart start: UnsafeMutablePointer<Element>,
        count: some Carrier.`Protocol`<Cardinal>
    ) {
        unsafe self.init(
            _unsafeStart: start,
            count: Int(bitPattern: count.underlying)
        )
    }

    @inlinable
    @_lifetime(&self)
    public mutating func extracting(first maxLength: some Carrier.`Protocol`<Cardinal>) -> Self {
        self._mutatingExtracting(first: Int(bitPattern: maxLength.underlying))
    }

    @inlinable
    @_lifetime(&self)
    public mutating func extracting(droppingFirst k: some Carrier.`Protocol`<Cardinal>) -> Self {
        self._mutatingExtracting(droppingFirst: Int(bitPattern: k.underlying))
    }

    @inlinable
    @_lifetime(&self)
    public mutating func extracting(last maxLength: some Carrier.`Protocol`<Cardinal>) -> Self {
        self._mutatingExtracting(last: Int(bitPattern: maxLength.underlying))
    }

    @inlinable
    @_lifetime(&self)
    public mutating func extracting(droppingLast k: some Carrier.`Protocol`<Cardinal>) -> Self {
        self._mutatingExtracting(droppingLast: Int(bitPattern: k.underlying))
    }
}
