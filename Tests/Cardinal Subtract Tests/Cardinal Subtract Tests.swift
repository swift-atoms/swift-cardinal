import Cardinal_Subtract
import Testing

@Test
func `saturating subtraction clamps at zero`() {
    let three = Cardinal::Cardinal(3 as UInt)
    let five = Cardinal::Cardinal(5 as UInt)
    #expect(three.subtract.saturating(five) == .zero)
}
