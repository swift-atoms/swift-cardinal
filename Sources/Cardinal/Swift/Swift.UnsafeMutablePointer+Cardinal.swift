public import Carrier

extension Swift.UnsafeMutablePointer {

    @inlinable
    public func initialize(
        from source: UnsafePointer<Pointee>,
        count: some Carrier::Carrier.`Protocol`<Cardinal>
    ) {
        guard let length = try? Int(count.underlying) else {
            preconditionFailure("Count is not representable as Int")
        }
        unsafe self.initialize(from: source, count: length)
    }
}

extension Swift.UnsafeMutablePointer where Pointee: ~Copyable {

    @inlinable
    public func moveInitialize(
        from source: UnsafeMutablePointer,
        count: some Carrier::Carrier.`Protocol`<Cardinal>
    ) {
        guard let length = try? Int(count.underlying) else {
            preconditionFailure("Count is not representable as Int")
        }
        unsafe self.moveInitialize(from: source, count: length)
    }
}
