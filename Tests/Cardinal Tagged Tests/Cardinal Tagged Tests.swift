import Cardinal_Tagged
import Testing

private enum UserCount {}

@Test
func `tagged cardinal preserves its domain and count`() throws(Cardinal::Cardinal.Error) {
    let users = Tagged::Tagged<UserCount, Cardinal::Cardinal>(5 as UInt)
    let increment = Tagged::Tagged<UserCount, Cardinal::Cardinal>(3 as UInt)
    #expect(try users.add.exact(increment).underlying == Cardinal::Cardinal(8 as UInt))
}
