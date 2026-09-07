public import Addition
public import Magnitude
public import Property
public import Subtraction
public import Tagged

extension Cardinal: Magnitude::Scalar {
    @inlinable
    public var isFinite: Bool { true }
}

extension Magnitude::Magnitude where Storage == Cardinal {

    @inlinable
    public init(_ cardinal: Cardinal) {
        try! self.init(validating: cardinal)
    }

    @inlinable
    public static func + (lhs: Self, rhs: Self) -> Self {
        do { return try lhs.add.exact(rhs) }
        catch { preconditionFailure("Magnitude overflow in addition") }
    }

    @inlinable
    public static func += (lhs: inout Self, rhs: Self) { lhs = lhs + rhs }

    @inlinable
    public var add: Property<Addition, Self> { Property(self) }

    @inlinable
    public var subtract: Property<Subtraction, Self> { Property(self) }
}

extension Property where Tag == Addition, Base == Magnitude::Magnitude<Cardinal> {
    @inlinable
    public func exact(_ other: Base) throws(Cardinal.Error) -> Base {
        Base(try base.value.add.exact(other.value))
    }

    @inlinable
    public func saturating(_ other: Base) -> Base {
        Base(base.value.add.saturating(other.value))
    }
}

extension Property where Tag == Subtraction, Base == Magnitude::Magnitude<Cardinal> {
    @inlinable
    public func exact(_ other: Base) throws(Cardinal.Error) -> Base {
        Base(try base.value.subtract.exact(other.value))
    }

    @inlinable
    public func saturating(_ other: Base) -> Base {
        Base(base.value.subtract.saturating(other.value))
    }
}

extension Tagged where Underlying == Magnitude::Magnitude<Cardinal>, Tag: ~Copyable & ~Escapable {

    @inlinable
    public static func + (lhs: Self, rhs: Self) -> Self {
        Self(_unchecked: lhs.underlying + rhs.underlying)
    }

    @inlinable
    public static func += (lhs: inout Self, rhs: Self) {
        lhs = lhs + rhs
    }

    @inlinable
    public var add: Property<Addition, Self> { Property(self) }

    @inlinable
    public var subtract: Property<Subtraction, Self> { Property(self) }
}

extension Property {

    @inlinable
    public func exact<T: ~Copyable & ~Escapable>(
        _ other: Base
    ) throws(Cardinal.Error) -> Base
    where
        Tag == Addition,
        Base == Tagged<T, Magnitude::Magnitude<Cardinal>>
    {
        try base.map { magnitude throws(Cardinal.Error) in
            try magnitude.add.exact(other.underlying)
        }
    }

    @inlinable
    public func saturating<T: ~Copyable & ~Escapable>(_ other: Base) -> Base
    where
        Tag == Addition,
        Base == Tagged<T, Magnitude::Magnitude<Cardinal>>
    {
        base.map { $0.add.saturating(other.underlying) }
    }

    @inlinable
    public func exact<T: ~Copyable & ~Escapable>(
        _ other: Base
    ) throws(Cardinal.Error) -> Base
    where
        Tag == Subtraction,
        Base == Tagged<T, Magnitude::Magnitude<Cardinal>>
    {
        try base.map { magnitude throws(Cardinal.Error) in
            try magnitude.subtract.exact(other.underlying)
        }
    }

    @inlinable
    public func saturating<T: ~Copyable & ~Escapable>(_ other: Base) -> Base
    where
        Tag == Subtraction,
        Base == Tagged<T, Magnitude::Magnitude<Cardinal>>
    {
        base.map { $0.subtract.saturating(other.underlying) }
    }
}
