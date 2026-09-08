import Cardinal
import Equation
import Testing

@Suite
struct `Cardinal Equation Tests` {
    @Test
    func `Cardinal satisfies Equation Protocol`() {
        func acceptsEquationProtocol<T: Equation.`Protocol`>(_ value: T) -> T {
            value
        }

        let cardinal = Cardinal(UInt(3))
        #expect(acceptsEquationProtocol(cardinal) == cardinal)
    }

    @Test
    func `Equal cardinals compare equal`() {
        #expect(Cardinal(UInt(3)) == Cardinal(UInt(3)))
    }

    @Test
    func `Different cardinals compare unequal`() {
        #expect(Cardinal(UInt(2)) != Cardinal(UInt(3)))
    }
}
