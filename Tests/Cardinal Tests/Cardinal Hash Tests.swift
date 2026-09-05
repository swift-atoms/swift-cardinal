import Cardinal
import Testing

@Test
func `equal cardinals hash as one set member`() {
    let value = Cardinal(2 as UInt)
    #expect(Set([value, value]).count == 1)
}
