import Cardinal
import Testing

@Test
func `cardinals compare by their unsigned value`() {
    #expect(Cardinal(2 as UInt) < Cardinal(3 as UInt))
}
