import Cardinal
import Magnitude
import Testing

@Test
func `cardinal magnitudes preserve the full count range`() throws {
    let zero = Magnitude<Cardinal>(Cardinal(0))
    let maximum = Magnitude<Cardinal>(Cardinal.max)
    #expect(zero == .zero)
    #expect(maximum.value == Cardinal.max)
    #expect(try Magnitude<Cardinal>(validating: Cardinal.max) == maximum)
}

@Test
func `magnitude arithmetic delegates while preserving the value role`() throws {
    let three = Magnitude<Cardinal>(Cardinal(3))
    let five = Magnitude<Cardinal>(Cardinal(5))
    let maximum = Magnitude<Cardinal>(Cardinal.max)
    let sum: Magnitude<Cardinal> = try three.add.exact(five)
    #expect(sum.value == Cardinal(8))
    #expect(three + five == sum)
    #expect(try five.subtract.exact(three).value == Cardinal(2))
    #expect(three.subtract.saturating(five) == .zero)
    #expect(maximum.add.saturating(three) == maximum)
    #expect(throws: Cardinal.Error.overflow) { try maximum.add.exact(three) }
}
