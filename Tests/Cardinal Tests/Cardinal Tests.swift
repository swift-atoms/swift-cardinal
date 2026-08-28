import Cardinal
import Testing

@Test
func `cardinal stores an unsigned count`() {
    let count = Cardinal::Cardinal(42 as UInt)
    #expect(count.rawValue == 42)
}

@Test
func `standard conformances are intrinsic`() {
    let two: Cardinal::Cardinal = 2
    let three = Cardinal::Cardinal(UInt8(3))

    #expect(two < three)
    #expect(Set([two, two, three]).count == 2)
    #expect(two.description == "2")
}
