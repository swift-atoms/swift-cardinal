public import Cardinal

extension Cardinal::Cardinal {

    @inlinable
    public init(_ value: Swift.Int) throws(Self.Error) {
        guard value >= .zero else {
            throw .negativeSource(value)
        }
        self.init(UInt(value))
    }
}
