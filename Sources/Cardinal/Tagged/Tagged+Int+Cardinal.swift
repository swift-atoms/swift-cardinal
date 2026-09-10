public import Tagged

extension Tagged::Tagged where Underlying == Cardinal, Tag: ~Copyable & ~Escapable {

    @inlinable
    public init(_ int: Int) throws(Cardinal.Error) {
        self.init(try Cardinal(int))
    }
}
