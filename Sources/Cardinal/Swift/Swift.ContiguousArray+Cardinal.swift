public import Carrier

extension Swift.ContiguousArray {

    @inlinable
    public init(repeating repeatedValue: Element, count: some Carrier::Carrier.`Protocol`<Cardinal>) {
        guard let length = try? Int(count.underlying) else {
            preconditionFailure("Array count is not representable as Int")
        }
        self.init(repeating: repeatedValue, count: length)
    }

    @inlinable
    public init<C: Carrier::Carrier.`Protocol`<Cardinal>, E: Swift.Error>(
        unsafeUninitializedCapacity: C,
        initializingWith initializer: (
            _ buffer: inout UnsafeMutableBufferPointer<Element>,
            _ initializedCount: inout C
        ) throws(E) -> Void
    ) throws(E) {
        guard let capacity = try? Int(unsafeUninitializedCapacity.underlying) else {
            preconditionFailure("Array capacity is not representable as Int")
        }
        try unsafe self.init(
            unsafeUninitializedCapacity: capacity,
            initializingWith: { buffer, count throws(E) in
                var typedCount = C(Cardinal(UInt(count)))
                defer {
                    guard let initializedCount = try? Int(typedCount.underlying) else {
                        preconditionFailure("Initialized count is not representable as Int")
                    }
                    precondition(initializedCount <= capacity, "Initialized count exceeds capacity")
                    count = initializedCount
                }
                try unsafe initializer(&buffer, &typedCount)
            }
        )
    }
}
