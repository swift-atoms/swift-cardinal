#if SYNCHRONIZATION_AVAILABLE
public import Synchronization
#endif


extension Cardinal: Swift.CustomStringConvertible {

    public var description: String { rawValue.description }
}
