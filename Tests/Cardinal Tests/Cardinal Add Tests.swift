import Cardinal
import Testing

@Test
func `saturating addition clamps at the maximum`() {
    let maximum = Cardinal(UInt.max)
    let one = Cardinal(1 as UInt)
    #expect(maximum.add.saturating(one) == maximum)
}
