#if Algebra
public import Algebra

extension Cardinal {

    @inlinable
    public static var monoid: Algebra.Monoid<Self>.Commutative {
        .init(
            monoid: .init(
                identity: Cardinal(UInt.zero),
                combining: { $0 + $1 }
            )
        )
    }
}
#endif
