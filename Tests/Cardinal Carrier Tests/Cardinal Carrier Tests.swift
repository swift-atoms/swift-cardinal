import Cardinal_Carrier
import Testing

@Test
func `cardinal is its own carrier`() {
    let count = Cardinal::Cardinal(7 as UInt)
    #expect(count.cardinal == count)
}
