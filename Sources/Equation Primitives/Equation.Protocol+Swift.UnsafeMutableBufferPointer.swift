// Equation.Protocol+Swift.UnsafeMutableBufferPointer.swift
// Conditional conformance for UnsafeMutableBufferPointer.

extension UnsafeMutableBufferPointer: Equation.`Protocol` {
    /// Returns whether two mutable buffer pointers have the same base address and count.
    ///
    /// - Note: Uses `copy` to copy the borrowed buffer pointer values, then
    ///   compares base addresses via `Int(bitPattern:)`.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand side value.
    ///   - rhs: The right-hand side value.
    /// - Returns: `true` if `lhs` has the same base address and count as `rhs`.
    @inlinable
    @_disfavoredOverload
    public static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
        let lhsCopy = copy lhs
        let rhsCopy = copy rhs
        guard lhsCopy.count == rhsCopy.count else { return false }
        let lhsAddr = unsafe lhsCopy.baseAddress.map { Int(bitPattern: $0) }
        let rhsAddr = unsafe rhsCopy.baseAddress.map { Int(bitPattern: $0) }
        return lhsAddr == rhsAddr
    }
}
