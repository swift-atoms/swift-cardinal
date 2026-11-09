extension Swift.PartialRangeUpTo: Cardinal.Range where Bound == Cardinal {
    public var bounds: Cardinal.Bounds {
        upperBound == .zero ? .empty : .bounded(minimum: .zero, maximum: Cardinal(upperBound.rawValue - 1))
    }
}
