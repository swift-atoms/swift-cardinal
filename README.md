# Cardinal

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

A typed cardinal-number primitive — `Cardinal`, a non-negative count, with policy-aware overflow / underflow handling and a phantom-tagged variant `Tagged<Tag, Cardinal>` for per-domain count types.

`Cardinal` separates *count* from the two other things stdlib calls `Int`: **position** (see [`swift-ordinal`](https://github.com/swift-molecules/swift-ordinal)) and **signed offset** (see [`swift-affine`](https://github.com/swift-molecules/swift-affine)).

---

## Quick Start

```swift
import Cardinal

// Bare Cardinal — a non-negative count
let items: Cardinal = 5
let total = items + Cardinal(3)                            // 8 (trapping +)
let saturated = items.subtract.saturating(Cardinal(7))     // 0 (monus)
let amount = try items.subtract.exact(Cardinal(2))         // 3 or throws

// Phantom-tagged Cardinal — distinct count types per domain
extension User  { typealias Count = Tagged<Self, Cardinal> }
extension Inbox { typealias Count = Tagged<Self, Cardinal> }

let users: User.Count = 100
let inbox: Inbox.Count = 12
// users + inbox  // ❌ compile error — different tags

let next = try users.add.exact(1)  // User.Count(101)
```

Cardinal is backed by `UInt`, which makes non-negativity representational rather than runtime-checked. Subtraction has no `-` operator because `0 - 1` is undefined for cardinals; `.subtract.saturating` (monus, clamps at zero) and `.subtract.exact` (throws on underflow) are the two policies the API ships.

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-molecules/swift-cardinal.git", branch: "main")
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Cardinal", package: "swift-cardinal"),
    ]
)
```

The package is pre-1.0 — until 0.1.0 is tagged, depend on `branch: "main"` rather than `from: "0.1.0"`. Requires Swift 6.3.1 and macOS 26 / iOS 26 / tvOS 26 / watchOS 26 / visionOS 26 (or the matching Linux / Windows toolchain).

---

## Architecture

Four library products covering the bare type, its standard-library integration, the umbrella, and a Test Support target.

| Product | Target | Purpose |
|---------|--------|---------|
| `Cardinal` | `Sources/Cardinal/` | Umbrella — re-exports Core and SLI; the default import for application code. Adds `Tagged<Tag, Cardinal>` arithmetic accessors (`.add`, `.subtract`) bridging the Property-based API to phantom-tagged counts. |
| `Cardinal Core` | `Sources/Cardinal Core/` | The `Cardinal` type itself — backing `UInt` storage, trapping `+`, the `.add` / `.subtract` policy-aware accessors, and `Cardinal.Error`. |
| `Cardinal Standard Library Integration` | `Sources/Cardinal Standard Library Integration/` | Conformances and integration overloads bridging Cardinal into the standard library: `ExpressibleByIntegerLiteral`, `Int(_:Cardinal)` conversions, `UnsafeBufferPointer` / `Span` / `MutableSpan` / `OutputSpan` initializers accepting `some Carrier.`Protocol`<Cardinal>` counts. |
| `Cardinal Test Support` | `Tests/Support/` | Re-exports the umbrella + Tagged Test Support fixtures for downstream test consumers. |

Import the narrowest product you need: `Cardinal Core` for just the type, `Cardinal` (the umbrella) for the full surface including SLI bridges and Tagged-cardinal arithmetic.

The package depends on five molecules — `swift-tagged`, `swift-carrier`, `swift-property`, `swift-equation`, `swift-comparison`. See [Related Packages](#related-packages).

Foundation-free.

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS 26 | Full support |
| Linux | Full support (CI matrix) |
| Windows | Full support (CI matrix) |
| iOS / tvOS / watchOS / visionOS | Supported |
| Swift Embedded | Supported (no concurrency surface, no Foundation) |

---

## Related Packages

Direct dependencies (all already-public Tier 0 molecules):

- [swift-tagged](https://github.com/swift-molecules/swift-tagged) — provides `Tagged<Tag, Underlying>` for the phantom-tagged `Tagged<Tag, Cardinal>` surface.
- [swift-carrier](https://github.com/swift-molecules/swift-carrier) — provides `Carrier.`Protocol`<Underlying>`, the unified super-protocol Cardinal conforms to (as a trivial self-carrier, `Underlying = Cardinal`).
- [swift-property](https://github.com/swift-molecules/swift-property) — provides `Property<Tag, Base>`, the carrier underlying the `.add` / `.subtract` policy-aware accessors.
- [swift-equation](https://github.com/swift-molecules/swift-equation) — provides `Equation.`Protocol``, the `Equatable`-shape conformance Cardinal exposes.
- [swift-comparison](https://github.com/swift-molecules/swift-comparison) — provides `Comparison.`Protocol``, the `Comparable`-shape conformance Cardinal exposes.

Companion molecules covering the other two things stdlib calls `Int`:

- [swift-ordinal](https://github.com/swift-molecules/swift-ordinal) — `Ordinal`, a non-negative position in a 0-indexed sequence.
- [swift-affine](https://github.com/swift-molecules/swift-affine) — `Affine.Discrete.Vector`, a signed offset between ordinal positions.

---

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
