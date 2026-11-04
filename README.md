# swift-cardinal

Use this package when you need a count that can never be negative, and want arithmetic on it to say what happens at the edges. Start from `Cardinal`. Wrap it in a `Tagged` type or your own carrier to keep counts of different things apart. For a position rather than a count, use swift-ordinal. With the `Algebra` trait, `Cardinal.monoid` gives the commutative monoid of counts under addition.

## Laws

- `Cardinal` holds a `UInt`, so its range is zero through `UInt.max`.
- `+` traps on overflow. `Cardinal.add.exact(_:)` throws an overflow error instead, and `Cardinal.add.saturating(_:)` stops at `Cardinal.max`.
- There is no `-` operator. `Cardinal.subtract.exact(_:)` throws an underflow error below zero, and `Cardinal.subtract.saturating(_:)` stops at zero.
- A carrier whose underlying value is a `Cardinal` gets the same addition and subtraction, and keeps its own type through them.
- Creating a `Cardinal` from an `Int` throws for a negative value. Converting a `Cardinal` to an `Int` throws above `Int.max`. The `bitPattern:` conversion wraps instead, and the `clamping:` conversion stops at `Int.max`.
- The standard library overloads that take a `Cardinal` count, for arrays, collections, spans and buffers, trap when the count is above `Int.max`.
- Shifting by a `Cardinal` traps when the amount is not less than the bit width of the value shifted.
- A range of cardinals reports `nil` as its maximum only when it has no upper bound. A half-open range reports one less than its upper bound, or zero when the upper bound is zero. `Cardinal.Range.permitsAnother(after:)` is true while the count is below the maximum.
