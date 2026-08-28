import Cardinal_Error
import Testing

@Test
func `cardinal errors identify their cause`() {
    #expect(Cardinal::Cardinal.Error.overflow != .underflow)
    #expect(Cardinal::Cardinal.Error.negativeSource(-1) == .negativeSource(-1))
}

@Test
func `cardinal initializes from a nonnegative Int`() throws {
    #expect(try Cardinal::Cardinal(Int(3)).rawValue == 3)
    #expect(throws: Cardinal::Cardinal.Error.negativeSource(-1)) {
        try Cardinal::Cardinal(Int(-1))
    }
}
