// Equation.Protocol+Swift.Range.swift
// Conditional conformance for Range when Bound is Copyable.

extension Range: Equation.`Protocol` where Bound: Equation.`Protocol` & Copyable {
    /// Returns whether two ranges are equal.
    ///
    /// Two ranges are equal if they have equal lower and upper bounds.
    ///
    /// - Note: Uses `copy` to enable property access on borrowed values.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand side value.
    ///   - rhs: The right-hand side value.
    /// - Returns: `true` if `lhs` is equal to `rhs`.
    @_disfavoredOverload
    @inlinable
    public static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
        let lhsCopy = copy lhs
        let rhsCopy = copy rhs
        return lhsCopy.lowerBound == rhsCopy.lowerBound && lhsCopy.upperBound == rhsCopy.upperBound
    }
}

extension ClosedRange: Equation.`Protocol` where Bound: Equation.`Protocol` & Copyable {
    /// Returns whether two closed ranges are equal.
    ///
    /// Two closed ranges are equal if they have equal lower and upper bounds.
    ///
    /// - Note: Uses `copy` to enable property access on borrowed values.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand side value.
    ///   - rhs: The right-hand side value.
    /// - Returns: `true` if `lhs` is equal to `rhs`.
    @_disfavoredOverload
    @inlinable
    public static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
        let lhsCopy = copy lhs
        let rhsCopy = copy rhs
        return lhsCopy.lowerBound == rhsCopy.lowerBound && lhsCopy.upperBound == rhsCopy.upperBound
    }
}
