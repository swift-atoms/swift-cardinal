#if Algebra
import Cardinal
import Algebra
import Testing

extension Cardinal {
    @Suite struct Monoid {
        @Suite struct Unit {}
            }
}

extension Cardinal.Monoid.Unit {
    @Test
    func `identity is zero`() {
        let monoid = Cardinal.monoid
        #expect(monoid.identity == Cardinal(UInt(0)))
    }

    @Test
    func `combining matches addition`() {
        let monoid = Cardinal.monoid
        let a = Cardinal(UInt(3))
        let b = Cardinal(UInt(5))
        #expect(monoid.combining(a, b) == a + b)
    }

    @Test
    func `identity left`() {
        let monoid = Cardinal.monoid
        let a = Cardinal(UInt(7))
        #expect(monoid.combining(monoid.identity, a) == a)
    }

    @Test
    func `identity right`() {
        let monoid = Cardinal.monoid
        let a = Cardinal(UInt(7))
        #expect(monoid.combining(a, monoid.identity) == a)
    }

    @Test
    func `commutativity`() {
        let monoid = Cardinal.monoid
        let a = Cardinal(UInt(3))
        let b = Cardinal(UInt(5))
        #expect(monoid.combining(a, b) == monoid.combining(b, a))
    }
}
#endif
