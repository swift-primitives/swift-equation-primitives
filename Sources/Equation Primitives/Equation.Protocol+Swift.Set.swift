// Equation.Protocol+Swift.Set.swift
// Conditional conformance for Set when Element is Copyable.

extension Set: Equation.`Protocol` where Element: Equation.`Protocol` & Copyable {
    /// Returns whether two sets are equal.
    ///
    /// Two sets are equal if they contain the same elements.
    ///
    /// - Important: This implementation uses stdlib `Set.contains(_:)`,
    ///   which relies on `Swift.Hashable`/`Swift.Equatable`. For correctness,
    ///   `Equation.Protocol.==` must be coherent with `Swift.Equatable.==` for `Element`.
    ///
    /// - Note: Uses `copy` to enable iteration on borrowed values.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand side value.
    ///   - rhs: The right-hand side value.
    /// - Returns: `true` if `lhs` is equal to `rhs`.
    @inlinable
    @_disfavoredOverload
    public static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
        let lhsCopy = copy lhs
        let rhsCopy = copy rhs
        guard lhsCopy.count == rhsCopy.count else { return false }
        for element in lhsCopy {
            if !rhsCopy.contains(element) { return false }
        }
        return true
    }
}
