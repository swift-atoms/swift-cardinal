public import Cardinal
public import Tagged

extension Tagged::Tagged where Underlying == Cardinal::Cardinal, Tag: ~Copyable & ~Escapable {

    @inlinable
    public init(_ uint: UInt) {
        self.init(Cardinal::Cardinal(uint))
    }
}
