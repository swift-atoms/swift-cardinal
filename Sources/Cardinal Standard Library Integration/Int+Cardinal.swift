public import Cardinal

extension Cardinal {

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
        _ cardinal: Cardinal
    ) throws(Cardinal.Error) {
        guard cardinal.rawValue <= Swift.UInt(Swift.Int.max) else {
            throw .overflow
        }
        self = Int(cardinal.rawValue)
    }

    @inlinable
    public init(bitPattern cardinal: Cardinal) {
        self = Int(bitPattern: cardinal.rawValue)
    }

    @inlinable
    public init(clamping cardinal: Cardinal) {
        self = Int(clamping: cardinal.rawValue)
    }
}
