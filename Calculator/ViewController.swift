//
//  ViewController.swift
//  Calculator
//
//  Created by Alejandro Xochihua on 18/02/15.
//  Copyright (c) 2015 CreaIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!

    var userIsInTheMiddle: Bool = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if (userIsInTheMiddle){
            display.text = display.text! + digit
            
        }else{
            display.text = digit
            userIsInTheMiddle = true
            
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if (userIsInTheMiddle){
            enter()
        }
        switch operation {

            case "×": performOperation(multiply)
            case "−": performOperation({(op1,op2) in op2 - op1 })
            case "+": performOperation({(op1: Double ,op2: Double) ->Double in return op1 + op2})
            case "÷": performOperation{$1 / $0}
            default: break
        }
        
    }
    
    func performOperation (operation: (Double,Double) ->Double){
        if (stackOperation.count >= 2){
            displayValue =  operation (stackOperation.removeLast() , stackOperation.removeLast())
            enter()
            
        }
    }
    
    
    func multiply (op1: Double ,op2: Double) ->Double {
       return op1 * op2
    }
    
    
    var stackOperation = Array<Double>()
    
    // Convierte valores String a Double de forma automatica
    @IBAction func enter() {
        userIsInTheMiddle   = false
        stackOperation.append(displayValue)
        println("operanStack \(stackOperation)")
    }
    
    
    // Convierte valores String a Double de forma automatica
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            userIsInTheMiddle   = false
            display.text = "\(newValue)"
        }
    }
}

