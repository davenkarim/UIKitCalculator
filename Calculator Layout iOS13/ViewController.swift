//
//  ViewController.swift
//  Calculator Layout iOS13
//
//  Created by Angela Yu on 01/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var resultLabel: UILabel!
    
    private var isTypingNumber = false
    private var firstNumber: Double = 0
    private var secondNumber: Double = 0
    private var operation: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = "0"
    }

    @IBAction func numberTapped(_ sender: UIButton) {
        guard let numberValue = sender.titleLabel?.text else { return }
        
        if isTypingNumber {
            if let currentText = resultLabel.text {
                resultLabel.text = currentText + numberValue
            }
        } else {
            resultLabel.text = numberValue
            isTypingNumber = true
        }
    }
    
    @IBAction func clearTapped(_ sender: UIButton) {
        resultLabel.text = "0"
        isTypingNumber = false
        firstNumber = 0
        secondNumber = 0
        operation = ""
    }
    
    @IBAction func plusMinusTapped(_ sender: UIButton) {
        if let value = Double(resultLabel.text!) {
            resultLabel.text = String(-value)
        }
    }
    
    @IBAction func percentTapped(_ sender: UIButton) {
        if let value = Double(resultLabel.text!) {
            resultLabel.text = String(value / 100)
        }
    }
    
    @IBAction func operationTapped(_ sender: UIButton) {
        isTypingNumber = false
        firstNumber = Double(resultLabel.text!)!
        operation = sender.titleLabel?.text ?? ""
    }
    
    @IBAction func equalsTapped(_ sender: UIButton) {
        isTypingNumber = false
        secondNumber = Double(resultLabel.text!)!
        
        var result: Double = 0
        
        switch operation {
        case "+":
            result = firstNumber + secondNumber
        case "-":
            result = firstNumber - secondNumber
        case "×":
            result = firstNumber * secondNumber
        case "÷":
            if secondNumber != 0 {
                result = firstNumber / secondNumber
            } else {
                resultLabel.text = "Error"
                return
            }
        default:
            break
        }
        
        resultLabel.text = formatResult(result)
    }

    @IBAction func dotTapped(_ sender: UIButton) {
        if !(resultLabel.text?.contains(".") ?? false) {
            resultLabel.text = (resultLabel.text ?? "0") + "."
        }
    }

    private func formatResult(_ value: Double) -> String {
        if floor(value) == value {
            return String(Int(value))
        } else {
            return String(value)
        }
    }
}
