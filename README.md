# Cardinal

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

A typed cardinal number: `Cardinal` is a non-negative count with policy-aware overflow and underflow handling, plus a phantom-tagged variant for domain-specific count types.

`Cardinal` separates *count* from the two other things stdlib calls `Int`: **position** (see [`swift-ordinal`](https://github.com/swift-atoms/swift-ordinal)) and **signed offset** (see [`swift-affine`](https://github.com/swift-atoms/swift-affine)).

---

## Quick Start

```swift
import Cardinal_Standard_Library_Integration
import Cardinal_Add
import Cardinal_Subtract

// Bare Cardinal — a non-negative count
let items: Cardinal::Cardinal = 5
let total = items + Cardinal::Cardinal(3)                            // 8 (trapping +)
let saturated = items.subtract.saturating(Cardinal::Cardinal(7))     // 0 (monus)
let amount = try items.subtract.exact(Cardinal::Cardinal(2))         // 3 or throws

// Phantom-tagged Cardinal — distinct count types per domain
extension User  { typealias Count = Tagged::Tagged<Self, Cardinal::Cardinal> }
extension Inbox { typealias Count = Tagged::Tagged<Self, Cardinal::Cardinal> }

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
    .package(url: "https://github.com/swift-atoms/swift-cardinal.git", branch: "main")
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

The package is pre-1.0 — until 0.1.0 is tagged, depend on `branch: "main"` rather than `from: "0.1.0"`. Requires Swift 6.4 and macOS 27 / iOS 27 / tvOS 27 / watchOS 27 / visionOS 27 (or the matching Linux / Windows toolchain).

---

## Architecture

The package exposes focused static modules. Import only the behavior a target uses.

| Product | Purpose |
|---------|---------|
| `Cardinal` | The `Cardinal` value and its unsigned storage. |
| `Cardinal Error` | Typed overflow, underflow, and negative-source errors. |
| `Cardinal Add` | Exact and saturating addition policies. |
| `Cardinal Subtract` | Exact and saturating subtraction policies. |
| `Cardinal Carrier` | Carrier protocol conformance and zero/one identities. |
| `Cardinal Equation` | Equality protocol conformance. |
| `Cardinal Hash` | Hash protocol conformance. |
| `Cardinal Comparison` | Ordering protocol conformance. |
| `Cardinal Tagged` | Domain-tagged cardinal construction and arithmetic. |
| `Cardinal Standard Library Integration` | Literal, conversion, collection, pointer, and span integrations. |

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

Direct dependencies (all already-public Tier 0 primitives):

- [swift-tagged](https://github.com/swift-atoms/swift-tagged) — provides `Tagged<Tag, Underlying>` for the phantom-tagged `Tagged<Tag, Cardinal>` surface.
- [swift-carrier](https://github.com/swift-atoms/swift-carrier) — provides `Carrier::Carrier.Protocol<Underlying>`, the unified carrier protocol Cardinal conforms to.
- [swift-property](https://github.com/swift-atoms/swift-property) — provides `Property<Tag, Base>`, the carrier underlying the `.add` / `.subtract` policy-aware accessors.
- [swift-equation](https://github.com/swift-atoms/swift-equation) — provides `Equation::Equation.Protocol`, the equality conformance Cardinal exposes.
- [swift-hash](https://github.com/swift-atoms/swift-hash) — provides `Hash::Hash.Protocol`, the hashing conformance Cardinal exposes.
- [swift-comparison](https://github.com/swift-atoms/swift-comparison) — provides `Comparison::Comparison.Protocol`, the ordering conformance Cardinal exposes.

Companion primitives covering the other two things stdlib calls `Int`:

- [swift-ordinal](https://github.com/swift-atoms/swift-ordinal) — `Ordinal`, a non-negative position in a 0-indexed sequence.
- [swift-affine](https://github.com/swift-atoms/swift-affine) — `Affine.Discrete.Vector`, a signed offset between ordinal positions.

---

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
