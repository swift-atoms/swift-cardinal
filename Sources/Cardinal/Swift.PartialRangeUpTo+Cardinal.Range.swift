extension Swift.PartialRangeUpTo: Cardinal.Range where Bound == Cardinal {
    public var minimum: Cardinal { .zero }
    public var maximum: Cardinal? { upperBound == .zero ? .zero : Cardinal(upperBound.rawValue - 1) }
}
