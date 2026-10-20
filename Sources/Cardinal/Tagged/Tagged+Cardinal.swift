public import Tagged

extension Tagged::Tagged where Underlying == Cardinal, Tag: ~Copyable & ~Escapable {

    @inlinable
    public init(_ uint: UInt) {
        self.init(Cardinal(uint))
    }
}
