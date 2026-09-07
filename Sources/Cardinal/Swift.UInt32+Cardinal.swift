public import Carrier

extension Swift.UInt32 {

    @inlinable
    public init(_ cardinal: some Carrier::Carrier.`Protocol`<Cardinal>) {
        self = UInt32(cardinal.underlying.rawValue)
    }
}
