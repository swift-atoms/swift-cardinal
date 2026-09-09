import Cardinal
import Testing

@Test func inclusiveAndExclusiveLimits() {
    let closed: ClosedRange<Cardinal> = 2...5
    let open: Range<Cardinal> = 2..<5
    #expect(closed.contains(5))
    #expect(!open.contains(5))
    #expect(closed.permitsAnother(after: 4))
    #expect(!closed.permitsAnother(after: 5))
    #expect(!open.permitsAnother(after: 4))
}
@Test func unboundedRangesDoNotUseAFiniteMaximum() {
    let range: PartialRangeFrom<Cardinal> = 2...
    #expect(range.maximum == nil)
    #expect(range.contains(2))
    #expect(range.permitsAnother(after: .max))
}
@Test func emptyAndZeroRangesAreDistinct() {
    let empty: PartialRangeUpTo<Cardinal> = ..<0
    let zero: PartialRangeThrough<Cardinal> = ...0
    #expect(!empty.contains(0))
    #expect(zero.contains(0))
    #expect(!zero.permitsAnother(after: 0))
}
