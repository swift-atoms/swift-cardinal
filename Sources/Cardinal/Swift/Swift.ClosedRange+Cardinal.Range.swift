extension Swift.ClosedRange: Cardinal.Range where Bound == Cardinal {
    public var bounds: Cardinal.Bounds { .bounded(minimum: lowerBound, maximum: upperBound) }
}
