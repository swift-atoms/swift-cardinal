public import Cardinal_Error
public import Cardinal
public import Tagged

extension Tagged::Tagged where Underlying == Cardinal::Cardinal, Tag: ~Copyable & ~Escapable {

    @inlinable
    public init(_ int: Int) throws(Cardinal::Cardinal.Error) {
        self.init(try Cardinal::Cardinal(int))
    }
}
