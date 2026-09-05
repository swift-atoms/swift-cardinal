import Addition
import Cardinal
import Carrier_Protocol
import Property
import Subtraction
import Testing

private struct Word: Carrier::Carrier.`Protocol` {
    let underlying: UInt8

    init(_ underlying: UInt8) {
        self.underlying = underlying
    }
}

private struct Count<Scope>: Carrier::Carrier.`Protocol`, Equatable {
    typealias Domain = Scope
    let underlying: Cardinal

    init(_ underlying: Cardinal) {
        self.underlying = underlying
    }
}

private enum Files {}

@Test
func `cardinal is its own carrier`() {
    let count = Cardinal(7 as UInt)
    #expect(count.cardinal == count)
}

@Test
func `carrier shifts retain a typed Cardinal count`() {
    let shift = Cardinal(1 as UInt)
    #expect((Word(4) << shift).underlying == 8)
    #expect((Word(4) >> shift).underlying == 2)
}

@Test
func `shared operation identities preserve a carrier domain`() throws {
    let two = Count<Files>(Cardinal(2 as UInt))
    let five = Count<Files>(Cardinal(5 as UInt))
    let addition: Property<Addition, Count<Files>> = two.add
    let subtraction: Property<Subtraction, Count<Files>> = five.subtract

    let seven: Count<Files> = try addition.exact(five)
    let three: Count<Files> = try subtraction.exact(two)

    #expect(seven == Count(Cardinal(7 as UInt)))
    #expect(three == Count(Cardinal(3 as UInt)))
}
