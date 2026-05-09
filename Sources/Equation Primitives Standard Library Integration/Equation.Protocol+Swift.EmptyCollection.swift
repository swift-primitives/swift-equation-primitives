#if swift(<6.4)
    // Equation.Protocol+Swift.EmptyCollection.swift
    // Conformance for EmptyCollection.

    extension EmptyCollection: Equation.`Protocol` where Element: Equation.`Protocol` {
        /// Returns whether two empty collections are equal.
        ///
        /// Always returns `true` since all empty collections are equal.
        ///
        /// - Parameters:
        ///   - lhs: The left-hand side value.
        ///   - rhs: The right-hand side value.
        /// - Returns: `true`.
        @inlinable
        @_disfavoredOverload
        public static func == (lhs: borrowing Self, rhs: borrowing Self) -> Bool {
            true
        }
    }

#endif
