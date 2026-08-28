public import Cardinal_Error
public import Cardinal_Primitive
public import Tagged

extension Tagged where Underlying == Cardinal, Tag: ~Copyable & ~Escapable {

    @inlinable
    public init(_ int: Int) throws(Cardinal.Error) {
        self.init(try Cardinal(int))
    }
}

extension Int {

    @inlinable
    public init<Tag: ~Copyable & ~Escapable>(_ count: Tagged<Tag, Cardinal>) throws(Cardinal.Error)
    {
        self = try Int(count.underlying)
    }

    @inlinable
    public init<Tag: ~Copyable & ~Escapable>(bitPattern count: Tagged<Tag, Cardinal>) {
        self = Int(bitPattern: count.underlying)
    }

    @inlinable
    public init<Tag: ~Copyable & ~Escapable>(clamping count: Tagged<Tag, Cardinal>) {
        self = Int(clamping: count.underlying)
    }
}
