#if SYNCHRONIZATION_AVAILABLE
    public import Synchronization

    extension Cardinal: AtomicRepresentable {

        public typealias AtomicRepresentation = UInt.AtomicRepresentation

        @inlinable
        public static func encodeAtomicRepresentation(
            _ value: consuming Cardinal
        ) -> AtomicRepresentation {
            UInt.encodeAtomicRepresentation(value.rawValue)
        }

        @inlinable
        public static func decodeAtomicRepresentation(
            _ representation: consuming AtomicRepresentation
        ) -> Cardinal {
            Cardinal(UInt.decodeAtomicRepresentation(representation))
        }
    }
#endif
