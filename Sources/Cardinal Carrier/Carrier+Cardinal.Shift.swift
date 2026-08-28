public import Cardinal
public import Carrier_Protocol

@_disfavoredOverload
@inlinable
public func << <C: Carrier::Carrier.`Protocol`>(
    lhs: C,
    rhs: some Carrier::Carrier.`Protocol`<Cardinal::Cardinal>
) -> C where C.Underlying: FixedWidthInteger {
    C(lhs.underlying << rhs.underlying.rawValue)
}

@_disfavoredOverload
@inlinable
public func >> <C: Carrier::Carrier.`Protocol`>(
    lhs: C,
    rhs: some Carrier::Carrier.`Protocol`<Cardinal::Cardinal>
) -> C where C.Underlying: FixedWidthInteger {
    C(lhs.underlying >> rhs.underlying.rawValue)
}

@_disfavoredOverload
@inlinable
public func <<= <C: Carrier::Carrier.`Protocol`>(
    lhs: inout C,
    rhs: some Carrier::Carrier.`Protocol`<Cardinal::Cardinal>
) where C.Underlying: FixedWidthInteger {
    lhs = lhs << rhs
}

@_disfavoredOverload
@inlinable
public func >>= <C: Carrier::Carrier.`Protocol`>(
    lhs: inout C,
    rhs: some Carrier::Carrier.`Protocol`<Cardinal::Cardinal>
) where C.Underlying: FixedWidthInteger {
    lhs = lhs >> rhs
}
