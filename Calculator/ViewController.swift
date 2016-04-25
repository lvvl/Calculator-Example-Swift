//
//  ViewController.swift
//  Calculator
//
//  Created by LIUWEI on 2016-04-23.
//  Copyright © 2016 LIUWEI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Wei Liu N01006606 -- Assignment#3")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var display: UILabel!
    
    var displayValue : Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    

    var userInTheMiddleOfTyping = false
    var point = 0
    
    @IBAction func NumberButtonPress(sender: UIButton) {
        
        let digit = sender.currentTitle!
        
        if digit == "." {
            point += 1
        }
        
        if userInTheMiddleOfTyping{
            if point == 0 || point == 1 {
                let textCurrentlyInDisplay = display.text!
                display.text = textCurrentlyInDisplay + digit
            }else if digit != "."{
                let textCurrentlyInDisplay = display.text!
                display.text = textCurrentlyInDisplay + digit
            }
        }else{
            display.text = digit
        }
        userInTheMiddleOfTyping = true
        
    }
    
    var brain = CalculatorBrain()

    @IBAction func performOperation(sender: UIButton) {
        
        
        if userInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle{
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
        point = 0
        
        
    }
}

