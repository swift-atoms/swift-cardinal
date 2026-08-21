public import Carrier_Primitives

extension UInt32 {

    @inlinable
    public init(_ cardinal: some Carrier.`Protocol`<Cardinal>) {
        self = UInt32(cardinal.underlying.rawValue)
    }
}
