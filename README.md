# Cardinal

Cardinal represents a nonnegative integral count. The package exposes two runtime
modules:

- `Cardinal` owns the value, errors, standard conformances, Carrier and Tagged
  bindings, arithmetic policies, and magnitude-role arithmetic.
- `Cardinal_Standard_Library_Integration` owns collection, pointer, span, and
  machine-integer adapters and reexports Cardinal.

```swift
import Cardinal

let count = Cardinal(3 as UInt)
let exact = try count.add.exact(Cardinal(4 as UInt))
let bounded = count.subtract.saturating(Cardinal(8 as UInt))
```

Cardinal binds its public policies to the shared operation atoms. Its addition
implementation delegates fixed-width work to `Addition.exact`, `.reporting`, and
`.saturating`; Cardinal translates those results into Cardinal values and errors.
Subtraction delegates to `Subtraction.exact` and `.saturating`, mapping an
unrepresentable unsigned result to `Cardinal.Error.underflow`.

Cardinal conforms to `Magnitude::Scalar`: every Cardinal is finite and
nonnegative. `Magnitude<Cardinal>` arithmetic is also owned here so exact
and saturating operations preserve the magnitude role and any outer Tagged domain.
Magnitude is not `Carrier<Cardinal>`; converting a magnitude to a count requires
explicit access to `.value`.

The former per-operation, Carrier, Tagged, Error, and protocol-conformance modules
have been removed. Manifests keep URL dependencies; the arithmetic workspace
provides local package resolution.
