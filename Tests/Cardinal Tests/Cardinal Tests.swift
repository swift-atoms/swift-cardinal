import Cardinal
import Testing

@Test
func `cardinal stores an unsigned count`() {
    let count = Cardinal::Cardinal(42 as UInt)
    #expect(count.rawValue == 42)
}
