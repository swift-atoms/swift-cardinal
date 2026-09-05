public import Cardinal
public import Tagged

extension Int {

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
