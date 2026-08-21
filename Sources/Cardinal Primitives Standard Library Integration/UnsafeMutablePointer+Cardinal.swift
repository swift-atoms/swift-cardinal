public import Carrier_Primitives

extension UnsafeMutablePointer {

    @inlinable
    public func initialize(
        from source: UnsafePointer<Pointee>,
        count: some Carrier.`Protocol`<Cardinal>
    ) {
        unsafe self.initialize(from: source, count: Int(bitPattern: count.underlying))
    }
}

extension UnsafeMutablePointer where Pointee: ~Copyable {

    @inlinable
    public func moveInitialize(
        from source: UnsafeMutablePointer,
        count: some Carrier.`Protocol`<Cardinal>
    ) {
        unsafe self.moveInitialize(from: source, count: Int(bitPattern: count.underlying))
    }
}
