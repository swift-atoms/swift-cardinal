public import Cardinal_Error
public import Cardinal
public import Tagged

extension Tagged::Tagged where Underlying == Cardinal::Cardinal, Tag: ~Copyable & ~Escapable {

    @inlinable
    public init(_ int: Int) throws(Cardinal::Cardinal.Error) {
        self.init(try Cardinal::Cardinal(int))
    }
}

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
