import Cardinal
import Tagged
import Testing

private final class Deaths {
    var ids: [Int] = []
}

private final class Object {
    let id: Int
    let deaths: Deaths
    init(_ id: Int, deaths: Deaths) {
        self.id = id
        self.deaths = deaths
    }
    deinit { deaths.ids.append(id) }
}

private struct Token: ~Copyable {
    let id: Int
    let deaths: Deaths
    deinit { deaths.ids.append(id) }
}

@Suite struct `Pointer counts preserve ownership` {
    @Test
    func `copy initialization retains source objects until both regions are destroyed`() {
        let deaths = Deaths()
        let source = UnsafeMutablePointer<Object>.allocate(capacity: 2)
        let target = UnsafeMutablePointer<Object>.allocate(capacity: 2)
        unsafe source.initialize(to: Object(1, deaths: deaths))
        unsafe source.advanced(by: 1).initialize(to: Object(2, deaths: deaths))

        unsafe target.initialize(from: UnsafePointer(source), count: Tagged<Object, Cardinal>(Cardinal(2)))
        #expect(unsafe target.pointee === source.pointee)
        #expect(unsafe target.advanced(by: 1).pointee === source.advanced(by: 1).pointee)
        unsafe source.deinitialize(count: 2)
        unsafe source.deallocate()
        #expect(deaths.ids.isEmpty)

        unsafe target.deinitialize(count: 2)
        unsafe target.deallocate()
        #expect(deaths.ids.sorted() == [1, 2])
    }

    @Test
    func `move initialization transfers noncopyable values exactly once`() {
        let deaths = Deaths()
        let source = UnsafeMutablePointer<Token>.allocate(capacity: 2)
        let target = UnsafeMutablePointer<Token>.allocate(capacity: 2)
        unsafe source.initialize(to: Token(id: 1, deaths: deaths))
        unsafe source.advanced(by: 1).initialize(to: Token(id: 2, deaths: deaths))

        unsafe target.moveInitialize(from: source, count: Tagged<Token, Cardinal>(Cardinal(2)))
        #expect(unsafe target.pointee.id == 1)
        #expect(unsafe target.advanced(by: 1).pointee.id == 2)
        #expect(deaths.ids.isEmpty)
        unsafe source.deallocate()

        unsafe target.deinitialize(count: 2)
        unsafe target.deallocate()
        #expect(deaths.ids.sorted() == [1, 2])
    }

    @Test
    func `zero count copies and moves leave source values initialized`() {
        let deaths = Deaths()
        let objects = UnsafeMutablePointer<Object>.allocate(capacity: 1)
        let copied = UnsafeMutablePointer<Object>.allocate(capacity: 1)
        unsafe objects.initialize(to: Object(1, deaths: deaths))
        unsafe copied.initialize(from: UnsafePointer(objects), count: Cardinal.zero)
        #expect(unsafe objects.pointee.id == 1)
        unsafe copied.deallocate()

        let tokens = UnsafeMutablePointer<Token>.allocate(capacity: 1)
        let moved = UnsafeMutablePointer<Token>.allocate(capacity: 1)
        unsafe tokens.initialize(to: Token(id: 2, deaths: deaths))
        unsafe moved.moveInitialize(from: tokens, count: Cardinal.zero)
        #expect(unsafe tokens.pointee.id == 2)
        #expect(deaths.ids.isEmpty)
        unsafe moved.deallocate()

        unsafe objects.deinitialize(count: 1)
        unsafe tokens.deinitialize(count: 1)
        unsafe objects.deallocate()
        unsafe tokens.deallocate()
        #expect(deaths.ids.sorted() == [1, 2])
    }
}
