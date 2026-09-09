extension Cardinal {
    public protocol Range {
        var minimum: Cardinal { get }
        var maximum: Cardinal? { get }
        func contains(_ count: Cardinal) -> Bool
    }
}

extension Cardinal.Range {
    public func permitsAnother(after count: Cardinal) -> Bool {
        maximum.map { count < $0 } ?? true
    }
}
