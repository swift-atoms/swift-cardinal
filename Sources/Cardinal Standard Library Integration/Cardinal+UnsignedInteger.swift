public import Cardinal

extension Cardinal {

    @inlinable
    public init<T: UnsignedInteger>(_ value: T) {
        self.init(UInt(value))
    }
}
