public import Carrier

@_disfavoredOverload
@inlinable
public func << <C: Carrier::Carrier.`Protocol`>(
    lhs: C,
    rhs: some Carrier::Carrier.`Protocol`<Cardinal>
) -> C where C.Underlying: FixedWidthInteger {
    C(lhs.underlying << rhs)
}

@_disfavoredOverload
@inlinable
public func >> <C: Carrier::Carrier.`Protocol`>(
    lhs: C,
    rhs: some Carrier::Carrier.`Protocol`<Cardinal>
) -> C where C.Underlying: FixedWidthInteger {
    C(lhs.underlying >> rhs)
}

@_disfavoredOverload
@inlinable
public func <<= <C: Carrier::Carrier.`Protocol`>(
    lhs: inout C,
    rhs: some Carrier::Carrier.`Protocol`<Cardinal>
) where C.Underlying: FixedWidthInteger {
    lhs = lhs << rhs
}

@_disfavoredOverload
@inlinable
public func >>= <C: Carrier::Carrier.`Protocol`>(
    lhs: inout C,
    rhs: some Carrier::Carrier.`Protocol`<Cardinal>
) where C.Underlying: FixedWidthInteger {
    lhs = lhs >> rhs
}
