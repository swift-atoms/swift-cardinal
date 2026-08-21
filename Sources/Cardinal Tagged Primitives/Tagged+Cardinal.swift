public import Cardinal_Primitive
public import Tagged_Primitives

extension Tagged where Underlying == Cardinal, Tag: ~Copyable & ~Escapable {

    @inlinable
    public init(_ uint: UInt) {
        self.init(Cardinal(uint))
    }
}
