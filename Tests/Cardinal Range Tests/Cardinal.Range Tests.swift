import Cardinal
import Testing

@Test func `inclusive and exclusive limits`() {
    let closed: ClosedRange<Cardinal> = 2...5
    let open: Range<Cardinal> = 2..<5
    #expect(closed.contains(5))
    #expect(!open.contains(5))
    #expect(closed.permitsAnother(after: 4))
    #expect(!closed.permitsAnother(after: 5))
    #expect(!open.permitsAnother(after: 4))
}
@Test func `unbounded ranges do not use a finite maximum`() {
    let range: PartialRangeFrom<Cardinal> = 2...
    #expect(range.bounds == .unbounded(minimum: 2))
    #expect(range.contains(2))
    #expect(range.permitsAnother(after: .max))
}
@Test func `empty and zero ranges are distinct`() {
    let empty: PartialRangeUpTo<Cardinal> = ..<0
    let zero: PartialRangeThrough<Cardinal> = ...0
    #expect(!empty.contains(0))
    #expect(zero.contains(0))
    #expect(!zero.permitsAnother(after: 0))
    #expect(empty.bounds == .empty)
    #expect(zero.bounds == .bounded(minimum: 0, maximum: 0))
}
@Test func `an empty half-open range reports no bounds and permits nothing`() {
    let empty: Range<Cardinal> = 5..<5
    #expect(empty.bounds == .empty)
    #expect(!empty.permitsAnother(after: 3))
    let open: Range<Cardinal> = 2..<5
    #expect(open.bounds == .bounded(minimum: 2, maximum: 4))
}
