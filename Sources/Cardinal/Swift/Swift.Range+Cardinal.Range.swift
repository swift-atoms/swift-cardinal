extension Swift.Range: Cardinal.Range where Bound == Cardinal {
    public var bounds: Cardinal.Bounds {
        isEmpty ? .empty : .bounded(minimum: lowerBound, maximum: Cardinal(upperBound.rawValue - 1))
    }
}
