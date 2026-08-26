public import Cardinal_Primitive
public import Hash

extension Cardinal: Hash.`Protocol` {

    @inlinable
    public borrowing func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}
