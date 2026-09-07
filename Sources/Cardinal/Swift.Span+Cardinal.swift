public import Carrier

extension Swift.Span where Element: ~Copyable {

    @unsafe
    @_lifetime(borrow start)
    @inlinable
    public init(
        _unsafeStart start: UnsafePointer<Element>,
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
    @_lifetime(copy self)
    public func extracting(first maxLength: some Carrier::Carrier.`Protocol`<Cardinal>) -> Self {
        guard let length = try? Int(maxLength.underlying) else {
            preconditionFailure("Length is not representable as Int")
        }
        return self.extracting(first: length)
    }

    @inlinable
    @_lifetime(copy self)
    public func extracting(droppingFirst k: some Carrier::Carrier.`Protocol`<Cardinal>) -> Self {
        guard let length = try? Int(k.underlying) else {
            preconditionFailure("Count is not representable as Int")
        }
        return self.extracting(droppingFirst: length)
    }

    @inlinable
    @_lifetime(copy self)
    public func extracting(last maxLength: some Carrier::Carrier.`Protocol`<Cardinal>) -> Self {
        guard let length = try? Int(maxLength.underlying) else {
            preconditionFailure("Length is not representable as Int")
        }
        return self.extracting(last: length)
    }

    @inlinable
    @_lifetime(copy self)
    public func extracting(droppingLast k: some Carrier::Carrier.`Protocol`<Cardinal>) -> Self {
        guard let length = try? Int(k.underlying) else {
            preconditionFailure("Count is not representable as Int")
        }
        return self.extracting(droppingLast: length)
    }
}
