public import Cardinal
public import Hash_Protocol

extension Cardinal::Cardinal: Hash::Hash.`Protocol` {

    @inlinable
    public borrowing func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}
