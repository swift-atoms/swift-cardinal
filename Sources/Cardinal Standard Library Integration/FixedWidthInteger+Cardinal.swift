public import Cardinal
public import Carrier_Protocol

@inlinable
public func << <RawValue: FixedWidthInteger>(
    lhs: RawValue,
    rhs: some Carrier::Carrier.`Protocol`<Cardinal::Cardinal>
) -> RawValue {
    let shift = Int(bitPattern: rhs.underlying)
    precondition(shift >= 0 && shift < RawValue.bitWidth, "Shift amount out of range")
    return lhs << shift
}

@inlinable
public func >> <RawValue: FixedWidthInteger>(
    lhs: RawValue,
    rhs: some Carrier::Carrier.`Protocol`<Cardinal::Cardinal>
) -> RawValue {
    let shift = Int(bitPattern: rhs.underlying)
    precondition(shift >= 0 && shift < RawValue.bitWidth, "Shift amount out of range")
    return lhs >> shift
}

@inlinable
public func <<= <RawValue: FixedWidthInteger>(
    lhs: inout RawValue,
    rhs: some Carrier::Carrier.`Protocol`<Cardinal::Cardinal>
) {
    lhs = lhs << rhs
}

@inlinable
public func >>= <RawValue: FixedWidthInteger>(
    lhs: inout RawValue,
    rhs: some Carrier::Carrier.`Protocol`<Cardinal::Cardinal>
) {
    lhs = lhs >> rhs
}
