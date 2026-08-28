public import Cardinal

extension Cardinal::Cardinal {

    public enum Error: Swift.Error, Hashable, Sendable {

        case overflow

        case underflow

        case negativeSource(Int)
    }
}
