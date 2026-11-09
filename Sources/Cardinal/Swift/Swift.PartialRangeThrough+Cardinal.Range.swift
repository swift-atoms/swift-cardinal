extension Swift.PartialRangeThrough: Cardinal.Range where Bound == Cardinal {
    public var bounds: Cardinal.Bounds { .bounded(minimum: .zero, maximum: upperBound) }
}
