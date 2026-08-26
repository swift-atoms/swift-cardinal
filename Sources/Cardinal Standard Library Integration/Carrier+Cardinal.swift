public import Cardinal_Primitive
public import Carrier

@_disfavoredOverload
@inlinable
public func << <C: Carrier.`Protocol`>(
    lhs: C,
    rhs: some Carrier.`Protocol`<Cardinal>
) -> C where C.Underlying: FixedWidthInteger {
    C(lhs.underlying << rhs)
}

@_disfavoredOverload
@inlinable
public func >> <C: Carrier.`Protocol`>(
    lhs: C,
    rhs: some Carrier.`Protocol`<Cardinal>
) -> C where C.Underlying: FixedWidthInteger {
    C(lhs.underlying >> rhs)
}

@_disfavoredOverload
@inlinable
public func <<= <C: Carrier.`Protocol`>(
    lhs: inout C,
    rhs: some Carrier.`Protocol`<Cardinal>
) where C.Underlying: FixedWidthInteger {
    lhs = lhs << rhs
}

@_disfavoredOverload
@inlinable
public func >>= <C: Carrier.`Protocol`>(
    lhs: inout C,
    rhs: some Carrier.`Protocol`<Cardinal>
) where C.Underlying: FixedWidthInteger {
    lhs = lhs >> rhs
}
