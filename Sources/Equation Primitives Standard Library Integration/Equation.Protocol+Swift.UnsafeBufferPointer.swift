#if swift(<6.4)
    // Equation.Protocol+Swift.UnsafeBufferPointer.swift
    // Conditional conformance for UnsafeBufferPointer.

    extension UnsafeBufferPointer: Equation.`Protocol` {
        /// Returns whether two buffer pointers have the same base address and count.
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
            let lhsCopy = unsafe copy lhs
            let rhsCopy = unsafe copy rhs
            guard lhsCopy.count == rhsCopy.count else { return false }
            let lhsAddr = unsafe lhsCopy.baseAddress.map { Int(bitPattern: $0) }
            let rhsAddr = unsafe rhsCopy.baseAddress.map { Int(bitPattern: $0) }
            return lhsAddr == rhsAddr
        }
    }

#endif
