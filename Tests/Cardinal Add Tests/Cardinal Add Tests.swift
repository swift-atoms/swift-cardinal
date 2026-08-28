import Cardinal_Add
import Testing

@Test
func `saturating addition clamps at the maximum`() {
    let maximum = Cardinal::Cardinal(UInt.max)
    let one = Cardinal::Cardinal(1 as UInt)
    #expect(maximum.add.saturating(one) == maximum)
}
