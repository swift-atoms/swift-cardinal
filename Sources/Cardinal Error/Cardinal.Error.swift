public import Cardinal_Primitive

extension Cardinal {

    public enum Error: Swift.Error, Hashable, Sendable {

        case overflow

        case underflow

        case negativeSource(Int)
    }
}
