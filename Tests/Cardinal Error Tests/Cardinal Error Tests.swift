import Cardinal_Error
import Testing

@Test
func `cardinal errors identify their cause`() {
    #expect(Cardinal::Cardinal.Error.overflow != .underflow)
    #expect(Cardinal::Cardinal.Error.negativeSource(-1) == .negativeSource(-1))
}
