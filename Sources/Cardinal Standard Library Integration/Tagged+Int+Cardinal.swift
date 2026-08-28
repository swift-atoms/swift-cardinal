public import Cardinal_Error
public import Cardinal
public import Tagged

extension Int {

    @inlinable
    public init<Tag: ~Copyable & ~Escapable>(_ count: Tagged::Tagged<Tag, Cardinal::Cardinal>) throws(Cardinal::Cardinal.Error)
    {
        self = try Int(count.underlying)
    }

    @inlinable
    public init<Tag: ~Copyable & ~Escapable>(bitPattern count: Tagged::Tagged<Tag, Cardinal::Cardinal>) {
        self = Int(bitPattern: count.underlying)
    }

    @inlinable
    public init<Tag: ~Copyable & ~Escapable>(clamping count: Tagged::Tagged<Tag, Cardinal::Cardinal>) {
        self = Int(clamping: count.underlying)
    }
}
