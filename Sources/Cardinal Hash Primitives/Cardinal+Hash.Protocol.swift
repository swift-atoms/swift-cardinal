public import Cardinal_Primitive
public import Hash_Primitives

extension Cardinal: Hash.`Protocol` {

    @inlinable
    public borrowing func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}
