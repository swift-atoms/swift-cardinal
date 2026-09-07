public import Carrier

extension Swift.MutableSpan where Element: ~Copyable {

    @unsafe
    @_lifetime(borrow start)
    @inlinable
    public init(
        _unsafeStart start: UnsafeMutablePointer<Element>,
        count: some Carrier::Carrier.`Protocol`<Cardinal>
    ) {
        guard let length = try? Int(count.underlying) else {
            preconditionFailure("Count is not representable as Int")
        }
        unsafe self.init(
            _unsafeStart: start,
            count: length
        )
    }

    @inlinable
    @_lifetime(&self)
    public mutating func extracting(first maxLength: some Carrier::Carrier.`Protocol`<Cardinal>) -> Self {
        guard let length = try? Int(maxLength.underlying) else {
            preconditionFailure("Length is not representable as Int")
        }
        return self._mutatingExtracting(first: length)
    }

    @inlinable
    @_lifetime(&self)
    public mutating func extracting(droppingFirst k: some Carrier::Carrier.`Protocol`<Cardinal>) -> Self {
        guard let length = try? Int(k.underlying) else {
            preconditionFailure("Count is not representable as Int")
        }
        return self._mutatingExtracting(droppingFirst: length)
    }

    @inlinable
    @_lifetime(&self)
    public mutating func extracting(last maxLength: some Carrier::Carrier.`Protocol`<Cardinal>) -> Self {
        guard let length = try? Int(maxLength.underlying) else {
            preconditionFailure("Length is not representable as Int")
        }
        return self._mutatingExtracting(last: length)
    }

    @inlinable
    @_lifetime(&self)
    public mutating func extracting(droppingLast k: some Carrier::Carrier.`Protocol`<Cardinal>) -> Self {
        guard let length = try? Int(k.underlying) else {
            preconditionFailure("Count is not representable as Int")
        }
        return self._mutatingExtracting(droppingLast: length)
    }
}
