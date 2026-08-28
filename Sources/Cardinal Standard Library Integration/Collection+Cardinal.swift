public import Carrier_Protocol

extension Collection {

    @inlinable
    public __consuming func prefix(_ maxLength: some Carrier::Carrier.`Protocol`<Cardinal::Cardinal>) -> SubSequence {
        self.prefix(Int(bitPattern: maxLength.underlying))
    }

    @inlinable
    public __consuming func suffix(_ maxLength: some Carrier::Carrier.`Protocol`<Cardinal::Cardinal>) -> SubSequence {
        self.suffix(Int(bitPattern: maxLength.underlying))
    }

    @inlinable
    public __consuming func dropFirst(_ k: some Carrier::Carrier.`Protocol`<Cardinal::Cardinal>) -> SubSequence {
        self.dropFirst(Int(bitPattern: k.underlying))
    }

    @inlinable
    public __consuming func dropLast(_ k: some Carrier::Carrier.`Protocol`<Cardinal::Cardinal>) -> SubSequence {
        self.dropLast(Int(bitPattern: k.underlying))
    }
}
