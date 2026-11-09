extension Swift.PartialRangeFrom: Cardinal.Range where Bound == Cardinal {
    public var bounds: Cardinal.Bounds { .unbounded(minimum: lowerBound) }
}
