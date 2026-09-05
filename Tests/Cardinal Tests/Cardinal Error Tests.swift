import Cardinal
import Testing

@Test
func `cardinal errors identify their cause`() {
    #expect(Cardinal.Error.overflow != .underflow)
    #expect(Cardinal.Error.negativeSource(-1) == .negativeSource(-1))
}

@Test
func `cardinal initializes from a nonnegative Int`() throws {
    #expect(try Cardinal(Int(3)).rawValue == 3)
    #expect(throws: Cardinal.Error.negativeSource(-1)) {
        try Cardinal(Int(-1))
    }
}
