#if SYNCHRONIZATION_AVAILABLE
import Synchronization
#endif


extension Cardinal: Swift.ExpressibleByIntegerLiteral {

    @_disfavoredOverload
    @inlinable
    public init(integerLiteral value: UInt) {
        self.init(value)
    }
}
