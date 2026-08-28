import Cardinal_Carrier
import Carrier_Protocol
import Testing

private struct Word: Carrier::Carrier.`Protocol` {
    let underlying: UInt8

    init(_ underlying: UInt8) {
        self.underlying = underlying
    }
}

@Test
func `cardinal is its own carrier`() {
    let count = Cardinal::Cardinal(7 as UInt)
    #expect(count.cardinal == count)
}

@Test
func `carrier shifts retain a typed Cardinal count`() {
    let shift = Cardinal::Cardinal(1 as UInt)
    #expect((Word(4) << shift).underlying == 8)
    #expect((Word(4) >> shift).underlying == 2)
}
