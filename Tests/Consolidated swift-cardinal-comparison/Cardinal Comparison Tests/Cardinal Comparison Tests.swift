import Cardinal
import Comparison
import Testing

@Suite
struct `Cardinal Comparison Tests` {
    @Test
    func `Cardinal satisfies Comparison Protocol`() {
        func acceptsComparisonProtocol<T: Comparison.`Protocol`>(_ value: T) -> T {
            value
        }

        let cardinal = Cardinal(UInt(3))
        #expect(acceptsComparisonProtocol(cardinal) == cardinal)
    }

    @Test
    func `Comparison orders cardinals`() {
        #expect(Comparison(Cardinal(UInt(2)), Cardinal(UInt(3))) == .less)
        #expect(Comparison(Cardinal(UInt(3)), Cardinal(UInt(3))) == .equal)
        #expect(Comparison(Cardinal(UInt(4)), Cardinal(UInt(3))) == .greater)
    }

    @Test
    func `Comparable conformance sorts cardinals`() {
        let values = [Cardinal(UInt(5)), Cardinal(UInt(1)), Cardinal(UInt(3))]
        #expect(values.sorted().map(\.rawValue) == [1, 3, 5])
    }
}
