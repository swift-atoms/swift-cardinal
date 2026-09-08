import struct Cardinal.Cardinal
import Cardinal
import Hash
import enum Hash.Hash
import Testing

@Suite
struct `Cardinal Hash Tests` {
    @Test
    func `Cardinal satisfies the domain hash protocol`() {
        let cardinal = Cardinal(42)

        #expect(acceptsDomainHash(cardinal))
        let _: Hash.Value = cardinal.hashValue
    }

    @Test
    func `Cardinal satisfies native Hashable through Hash Protocol`() {
        let values: Set<Cardinal> = [Cardinal(3), Cardinal(3), Cardinal(5)]

        #expect(acceptsNativeHash(cardinal: Cardinal(3)))
        #expect(values.count == 2)
    }

    private func acceptsDomainHash<Value: Hash.`Protocol`>(_ value: Value) -> Bool {
        true
    }

    private func acceptsNativeHash<Value: Swift.Hashable>(cardinal value: Value) -> Bool {
        true
    }
}
