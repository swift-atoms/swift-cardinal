extension Swift.Range: Cardinal.Range where Bound == Cardinal {
    public var minimum: Cardinal { lowerBound }
    public var maximum: Cardinal? { upperBound == .zero ? .zero : Cardinal(upperBound.rawValue - 1) }
}
