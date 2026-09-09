extension Swift.PartialRangeThrough: Cardinal.Range where Bound == Cardinal {
    public var minimum: Cardinal { .zero }
    public var maximum: Cardinal? { upperBound }
}
