#if SYNCHRONIZATION_AVAILABLE
import Synchronization
#endif


extension Cardinal: Swift.CustomStringConvertible {

    public var description: String { rawValue.description }
}
