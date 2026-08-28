import Cardinal_Comparison
import Testing

@Test
func `cardinals compare by their unsigned value`() {
    #expect(Cardinal::Cardinal(2 as UInt) < Cardinal::Cardinal(3 as UInt))
}
