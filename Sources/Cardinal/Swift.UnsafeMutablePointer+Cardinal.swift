public import Carrier

extension Swift.UnsafeMutablePointer {

    @inlinable
    public func initialize(
        from source: UnsafePointer<Pointee>,
        count: some Carrier::Carrier.`Protocol`<Cardinal>
    ) {
        unsafe self.initialize(from: source, count: Int(bitPattern: count.underlying))
    }
}

extension Swift.UnsafeMutablePointer where Pointee: ~Copyable {

    @inlinable
    public func moveInitialize(
        from source: UnsafeMutablePointer,
        count: some Carrier::Carrier.`Protocol`<Cardinal>
    ) {
        unsafe self.moveInitialize(from: source, count: Int(bitPattern: count.underlying))
    }
}
