extension Cardinal {
    public protocol Range {
        var bounds: Cardinal.Bounds { get }
        func contains(_ count: Cardinal) -> Bool
    }
}

extension Cardinal.Range {
    public func permitsAnother(after count: Cardinal) -> Bool {
        switch bounds {
        case .empty: false
        case .bounded(_, let maximum): count < maximum
        case .unbounded: true
        }
    }
}
