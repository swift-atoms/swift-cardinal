import Cardinal
import Testing

@Suite struct `Core cardinal values` {
    @Test func `counts add without domain tagging`() {
        #expect(Cardinal(UInt(2)) + Cardinal(UInt(3)) == Cardinal(UInt(5)))
    }
}
