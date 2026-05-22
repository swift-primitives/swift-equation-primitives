// exports.swift
// Re-export Equation Protocol Primitives (transitively re-exports
// Equation_Primitive) + Tagged so consumers importing
// Equation_Tagged_Primitives see Equation + Equation.Protocol + Tagged in
// scope via a single import.

@_exported public import Equation_Protocol_Primitives
@_exported public import Tagged_Primitives
