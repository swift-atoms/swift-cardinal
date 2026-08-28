public import Carrier_Protocol

extension UInt32 {

    @inlinable
    public init(_ cardinal: some Carrier::Carrier.`Protocol`<Cardinal::Cardinal>) {
        self = UInt32(cardinal.underlying.rawValue)
    }
}
