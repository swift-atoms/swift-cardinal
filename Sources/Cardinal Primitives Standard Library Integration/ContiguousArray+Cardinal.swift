public import Carrier_Primitives

extension ContiguousArray {

    @inlinable
    public init(repeating repeatedValue: Element, count: some Carrier.`Protocol`<Cardinal>) {
        self.init(repeating: repeatedValue, count: Int(bitPattern: count.underlying))
    }

    @inlinable
    public init<C: Carrier.`Protocol`<Cardinal>, E: Swift.Error>(
        unsafeUninitializedCapacity: C,
        initializingWith initializer: (
            _ buffer: inout UnsafeMutableBufferPointer<Element>,
            _ initializedCount: inout C
        ) throws(E) -> Void
    ) throws(E) {
        try unsafe self.init(
            unsafeUninitializedCapacity: Int(bitPattern: unsafeUninitializedCapacity.underlying),
            initializingWith: { buffer, count throws(E) in
                var typedCount = C(Cardinal(UInt(bitPattern: count)))
                try unsafe initializer(&buffer, &typedCount)
                count = Int(bitPattern: typedCount.underlying)
            }
        )
    }
}
