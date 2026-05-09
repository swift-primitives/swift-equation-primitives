#if swift(<6.4)
    // Equation.Protocol+Swift.Equatable.swift
    // Bridge implementations for Swift.Equatable types.

    // MARK: - Integer Conformances

    extension Int: Equation.`Protocol` {}
    extension Int8: Equation.`Protocol` {}
    extension Int16: Equation.`Protocol` {}
    extension Int32: Equation.`Protocol` {}
    extension Int64: Equation.`Protocol` {}
    extension UInt: Equation.`Protocol` {}
    extension UInt8: Equation.`Protocol` {}
    extension UInt16: Equation.`Protocol` {}
    extension UInt32: Equation.`Protocol` {}
    extension UInt64: Equation.`Protocol` {}

    // MARK: - Other Standard Library Types

    extension Bool: Equation.`Protocol` {}
    extension String: Equation.`Protocol` {}
    extension Character: Equation.`Protocol` {}
    extension Double: Equation.`Protocol` {}
    extension Float: Equation.`Protocol` {}

#endif
