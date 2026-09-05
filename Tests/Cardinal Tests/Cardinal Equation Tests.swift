import Cardinal
import Testing

@Test
func `cardinals support equality`() {
    #expect(Cardinal(2 as UInt) == Cardinal(2 as UInt))
}
