// Cardinal+Equation.Protocol.swift
// Conformance of Cardinal to Equation.Protocol — unconditional.
//
// `Equation.Protocol` aliases `Swift.Equatable`; this conformance therefore
// supplies the standard-library conformance directly.

public import Cardinal_Primitive
public import Equation_Primitives

extension Cardinal: Equation.`Protocol` {}
