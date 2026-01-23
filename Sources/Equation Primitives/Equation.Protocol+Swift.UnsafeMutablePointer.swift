// Equation.Protocol+Swift.UnsafeMutablePointer.swift
// Conditional conformance for UnsafeMutablePointer.

extension UnsafeMutablePointer: Equation.`Protocol` {
    /// Returns whether two mutable typed pointers point to the same address.
    ///
    /// - Note: Uses `copy` to copy the borrowed pointer values, converts to
    ///   `UnsafeRawPointer`, then compares via `Int(bitPattern:)`.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand side value.
    ///   - rhs: The right-hand side value.
    /// - Returns: `true` if `lhs` points to the same address as `rhs`.
    @inlinable
    @_disfavoredOverload
    public static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
        let lhsCopy = copy lhs
        let rhsCopy = copy rhs
        return unsafe Int(bitPattern: UnsafeRawPointer(lhsCopy)) == Int(bitPattern: UnsafeRawPointer(rhsCopy))
    }
}
