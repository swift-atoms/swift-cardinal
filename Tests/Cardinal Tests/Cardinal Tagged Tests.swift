import Cardinal
import Tagged
import Testing

private enum UserCount {}

@Test
func `tagged cardinal preserves its domain and count`() throws(Cardinal.Error) {
    let users = try Tagged::Tagged<UserCount, Cardinal>(5)
    let increment = Tagged::Tagged<UserCount, Cardinal>(3 as UInt)
    #expect(try users.add.exact(increment).underlying == Cardinal(8 as UInt))
}
