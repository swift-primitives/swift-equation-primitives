#if swift(<6.4)
    // Equation.Protocol+Swift.Result.swift
    // Conditional conformance for Result when Success and Failure are Copyable.

    extension Result: Equation.`Protocol` where Success: Equation.`Protocol` & Copyable, Failure: Equation.`Protocol` & Copyable {
        /// Returns whether two result values are equal.
        ///
        /// Two `.success` values are equal if their success values are equal.
        /// Two `.failure` values are equal if their failure values are equal.
        /// A `.success` never equals a `.failure`.
        ///
        /// - Note: Uses `copy` to enable pattern matching on borrowed enum values.
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
            switch lhsCopy {
            case .success(let l):
                switch rhsCopy {
                case .success(let r): return l == r
                case .failure: return false
                }

            case .failure(let l):
                switch rhsCopy {
                case .success: return false
                case .failure(let r): return l == r
                }
            }
        }
    }

#endif
