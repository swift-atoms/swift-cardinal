extension Swift.ClosedRange: Cardinal.Range where Bound == Cardinal {
    public var minimum: Cardinal { lowerBound }
    public var maximum: Cardinal? { upperBound }
}
