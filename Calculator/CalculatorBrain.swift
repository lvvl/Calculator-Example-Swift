//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by LIUWEI on 2016-04-23.
//  Copyright © 2016 LIUWEI. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    var accumulator = 0.0
    
    enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    var operations: Dictionary<String,Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "+" : Operation.BinaryOperation({return $0 + $1}),
        "-" : Operation.BinaryOperation({return $0 - $1}),
        "x" : Operation.BinaryOperation({return $0 * $1}),
        "÷" : Operation.BinaryOperation({return $0 / $1}),
        "=" : Operation.Equals,
    ]
    
    func setOperand(operand: Double){
        accumulator = operand
    }
    
    
    func performOperation(symbol:String){
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperation: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    
    }
    

    
    func executePendingBinaryOperation(){
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperation, accumulator)
            pending = nil
            
        }
    }
    
    var pending: PendingBinaryOperationInfo?
    
    
    
    struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperation: Double
    }
    

    
    var result: Double{
        get{
            return accumulator
        }
    }
}
