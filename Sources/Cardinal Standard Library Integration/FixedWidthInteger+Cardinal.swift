public import Cardinal_Primitive
public import Carrier

@inlinable
public func << <RawValue: FixedWidthInteger>(
    lhs: RawValue,
    rhs: some Carrier.`Protocol`<Cardinal>
) -> RawValue {
    let shift = Int(bitPattern: rhs.underlying)
    precondition(shift >= 0 && shift < RawValue.bitWidth, "Shift amount out of range")
    return lhs << shift
}

@inlinable
public func >> <RawValue: FixedWidthInteger>(
    lhs: RawValue,
    rhs: some Carrier.`Protocol`<Cardinal>
) -> RawValue {
    let shift = Int(bitPattern: rhs.underlying)
    precondition(shift >= 0 && shift < RawValue.bitWidth, "Shift amount out of range")
    return lhs >> shift
}

@inlinable
public func <<= <RawValue: FixedWidthInteger>(
    lhs: inout RawValue,
    rhs: some Carrier.`Protocol`<Cardinal>
) {
    lhs = lhs << rhs
}

@inlinable
public func >>= <RawValue: FixedWidthInteger>(
    lhs: inout RawValue,
    rhs: some Carrier.`Protocol`<Cardinal>
) {
    lhs = lhs >> rhs
}
