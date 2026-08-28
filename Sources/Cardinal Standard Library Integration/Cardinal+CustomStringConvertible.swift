public import Cardinal

extension Cardinal::Cardinal: CustomStringConvertible {

    public var description: String { rawValue.description }
}
