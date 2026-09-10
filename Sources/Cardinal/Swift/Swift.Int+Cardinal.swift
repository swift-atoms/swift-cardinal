public import Tagged

extension Swift.Int {

    @inlinable
    public init<Tag: ~Copyable & ~Escapable>(_ count: Tagged::Tagged<Tag, Cardinal>) throws(Cardinal.Error)
    {
        self = try Int(count.underlying)
    }

    @inlinable
    public init<Tag: ~Copyable & ~Escapable>(bitPattern count: Tagged::Tagged<Tag, Cardinal>) {
        self = Int(bitPattern: count.underlying)
    }

    @inlinable
    public init<Tag: ~Copyable & ~Escapable>(clamping count: Tagged::Tagged<Tag, Cardinal>) {
        self = Int(clamping: count.underlying)
    }
}

public import Carrier

extension Swift.Int {

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
    public init(bitPattern carrier: some Carrier::Carrier.`Protocol`<Cardinal>) {
        self = Int(bitPattern: carrier.underlying)
    }

    @inlinable
    public init(clamping cardinal: Cardinal) {
        self = Int(clamping: cardinal.rawValue)
    }
}
