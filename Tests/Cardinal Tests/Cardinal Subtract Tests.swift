import Cardinal
import Testing

@Test
func `saturating subtraction clamps at zero`() {
    let three = Cardinal(3 as UInt)
    let five = Cardinal(5 as UInt)
    #expect(three.subtract.saturating(five) == .zero)
}
