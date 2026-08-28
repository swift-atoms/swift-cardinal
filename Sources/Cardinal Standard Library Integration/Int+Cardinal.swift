public import Cardinal_Error
public import Cardinal
public import Carrier_Protocol

extension Cardinal::Cardinal {

    @inlinable
    public init(
        _ value: Swift.Int
    ) throws(Self.Error) {
        guard value >= .zero else {
            throw .negativeSource(value)
        }
        self.init(UInt(value))
    }

}

extension Int {

    @inlinable
    public init(
        _ cardinal: Cardinal::Cardinal
    ) throws(Cardinal::Cardinal.Error) {
        guard cardinal.rawValue <= Swift.UInt(Swift.Int.max) else {
            throw .overflow
        }
        self = Int(cardinal.rawValue)
    }

    @inlinable
    public init(bitPattern cardinal: Cardinal::Cardinal) {
        self = Int(bitPattern: cardinal.rawValue)
    }

    @inlinable
    public init(bitPattern carrier: some Carrier::Carrier.`Protocol`<Cardinal::Cardinal>) {
        self = Int(bitPattern: carrier.underlying)
    }

    @inlinable
    public init(clamping cardinal: Cardinal::Cardinal) {
        self = Int(clamping: cardinal.rawValue)
    }
}
