// Equation.Protocol+Swift.Optional.swift
// Conditional conformance for Optional when Wrapped is Copyable.

extension Optional: Equation.`Protocol` where Wrapped: Equation.`Protocol`, Wrapped: Copyable {
    /// Returns whether two optional values are equal.
    ///
    /// Two `.none` values are equal. A `.some` value equals another `.some`
    /// value if their wrapped values are equal.
    ///
    /// - Note: Uses `copy` to enable pattern matching on borrowed enum values.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand side value.
    ///   - rhs: The right-hand side value.
    /// - Returns: `true` if `lhs` is equal to `rhs`.
    @inlinable
    public static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
        let lhsCopy = copy lhs
        let rhsCopy = copy rhs
        switch lhsCopy {
        case .none:
            switch rhsCopy {
            case .none: return true
            case .some: return false
            }
        case let .some(l):
            switch rhsCopy {
            case .none: return false
            case let .some(r): return l == r
            }
        }
    }
}
