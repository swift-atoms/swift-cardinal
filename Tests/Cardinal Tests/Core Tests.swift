import Cardinal
import Tagged
import Testing

enum `Core Tests` {}

extension `Core Tests` {
    @Suite struct `Core cardinal values` {
        @Test func `counts add without domain tagging`() {
            #expect(Cardinal(UInt(2)) + Cardinal(UInt(3)) == Cardinal(UInt(5)))
        }

        @Test func `the exact conversion to Int is the count up to Int.max and nil above it`() {
            let largest = Cardinal(UInt(Int.max))
            let above = Cardinal(UInt(Int.max) + 1)
            #expect(Int(exactly: Cardinal.zero) == 0)
            #expect(Int(exactly: Cardinal(42 as UInt)) == 42)
            #expect(Int(exactly: largest) == Int.max)
            #expect(Int(exactly: above) == nil)
            #expect(Int(exactly: Cardinal.max) == nil)
            #expect(Int(exactly: Tagged<Self, Cardinal>(largest)) == Int.max)
            #expect(Int(exactly: Tagged<Self, Cardinal>(above)) == nil)
        }
    }
}
