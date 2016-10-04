//
//  ViewController.swift
//  SwiftCalc
//
//  Created by Zach Zeleznick on 9/20/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Width and Height of Screen for Layout
    var w: CGFloat!
    var h: CGFloat!
    var str: String!
    
    // IMPORTANT: Do NOT modify the name or class of resultLabel.
    //            We will be using the result label to run autograded tests.
    // MARK: The label to display our calculations
    var resultLabel = UILabel()
    
    // TODO: This looks like a good place to add some data structures.
    //       One data structure is initialized below for reference.
    var someDataStructure: [String] = [""]
    var secondDataStructure: [String] = [""]
    var currentOperator: String? = nil
    var clearLabelNextTimeButtonIsPressed: Bool = false
    let LIM = 8
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        w = view.bounds.size.width
        h = view.bounds.size.height
        navigationItem.title = "Calculator"
        // IMPORTANT: Do NOT modify the accessibilityValue of resultLabel.
        //            We will be using the result label to run autograded tests.
        resultLabel.accessibilityValue = "resultLabel"
        makeButtons()
        // Do any additional setup here.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // TODO: Ensure that resultLabel gets updated.
    //       Modify this one or create your own.
    func updateResultLabel(_ content: String) {
        resultLabel.text = content
    }
    
    func updateResultLabelWithDataStructure(_ dataStructure: [String]) {
        var str = ""
        for n in dataStructure {
            str += n
        }
        updateResultLabel(str)
    }
    
    func mergeDataStructure(withOperation operation:String) {
        let firstOperand = Helper.convertDataToString(data: someDataStructure)
        let secondOperand = Helper.convertDataToString(data: secondDataStructure)
        let result = calculate(a: firstOperand, b: secondOperand, operation: operation)
        someDataStructure = Helper.convertStringToDataStructure(str: result)
        secondDataStructure = [""]
    }
    
    // TODO: A calculate method with no parameters, scary!
    //       Modify this one or create your own.
    func calculate(a: String, b:String, operation: String) -> String {
        let op1 = Double(a)!
        let op2 = Double(b)!
        var result: Double = 0.0
        if operation == "+" {
            result = op1 + op2
        } else if operation == "-" {
            result = op1 - op2
        } else if operation == "/" {
            result = op1 / op2
        } else if operation == "*" {
            result = op1 * op2
        }
    
        return String(result.prettyOutput)
    }
    
    
    
    // REQUIRED: The responder to a number button being pressed.
    // invariants: currentOperator is nil if it is not pressed just now
    func numberPressed(_ sender: CustomButton) {
        guard Int(sender.content) != nil else { return }
        print("The number \(sender.content) was pressed")
        //updateResultLabel(sender.content)
        // Fill me in!
        // if on calculation
        if currentOperator == "=" {
            clearDataStructure()
            currentOperator = nil
        }
        
        if currentOperator != nil {
            if secondDataStructure.count < LIM {
                secondDataStructure.append(sender.content)
                updateResultLabelWithDataStructure(secondDataStructure)
                
            }
        } else {
            if someDataStructure.count < LIM {
                someDataStructure.append(sender.content)
                updateResultLabelWithDataStructure(someDataStructure)
            }
        }
        
        
        
    }
    
    // REQUIRED: The responder to an operator button being pressed.
    // This function is invoked when "/", "*", "-", "+", "=" "C" "+/-" "%"
    func operatorPressed(_ sender: CustomButton) {
        //guard Int(sender.content) != nil else { return }
        print("the operator \(sender.content) was pressed")
        // Fill me in!
        // If both data structure empty, return
        if someDataStructure == [""] {
            return
        }
        
        if sender.content == "C" {
            updateResultLabel("0")
            clearDataStructure()
            currentOperator = nil
        } else if sender.content == "+/-" {
            if currentOperator != nil && secondDataStructure != [""]{
                if secondDataStructure.contains("-") {
                    secondDataStructure.remove(at: 0)
                } else {
                    secondDataStructure.insert("-", at: 0)
                }
                updateResultLabelWithDataStructure(secondDataStructure)
            } else {
                if someDataStructure.contains("-") {
                    someDataStructure.remove(at: 0)
                } else {
                    someDataStructure.insert("-", at: 0)
                }
                updateResultLabelWithDataStructure(someDataStructure)
            }
        }
        
        
        if currentOperator != nil && someDataStructure != [""] && secondDataStructure != [""] {
            mergeDataStructure(withOperation: currentOperator!)
            updateResultLabelWithDataStructure(someDataStructure)
            currentOperator = nil
        }
        
        
    
        if ["*", "+", "-", "/", "="].contains(sender.content) {
            currentOperator = sender.content
        }
        
        
        
    }
    
    // REQUIRED: The responder to a number or operator button being pressed.
    // "0", "." pressed
    func buttonPressed(_ sender: CustomButton) {
        // Fill me in!
        
        
        if currentOperator != nil {
            if secondDataStructure.count < LIM {
                if sender.content == "." {
                    if !secondDataStructure.contains(".") {
                        if secondDataStructure == [""] {
                            secondDataStructure.append("0")
                        }
                        secondDataStructure.append(sender.content)
                        updateResultLabelWithDataStructure(secondDataStructure)
                    }
                } else if sender.content == "0" {
                    if secondDataStructure == ["", "0"] {
                        return
                    }
                    secondDataStructure.append(sender.content)
                    updateResultLabelWithDataStructure(secondDataStructure)
                }
            }
        } else {
            if someDataStructure.count < LIM {
                if sender.content == "." {
                    if !someDataStructure.contains(".") {
                        if someDataStructure == [""] {
                            someDataStructure.append("0")
                        }
                        someDataStructure.append(sender.content)
                        updateResultLabelWithDataStructure(someDataStructure)
                    }
                } else if sender.content == "0" {
                    if someDataStructure == ["", "0"] {
                        return
                    }
                    someDataStructure.append(sender.content)
                    updateResultLabelWithDataStructure(someDataStructure)
                }
            }
        }
    }
    
    
    // Custom: This resets someDataStructure. Invoked when operator "C" is pressed!
    func clearDataStructure() {
        someDataStructure = [""]
        secondDataStructure = [""]
    }
    
    
    
    
    
    // IMPORTANT: Do NOT change any of the code below.
    //            We will be using these buttons to run autograded tests.
    
    func makeButtons() {
        // MARK: Adds buttons
        let digits = (1..<10).map({
            return String($0)
        })
        let operators = ["/", "*", "-", "+", "="]
        let others = ["C", "+/-", "%"]
        let special = ["0", "."]
        
        let displayContainer = UIView()
        view.addUIElement(displayContainer, frame: CGRect(x: 0, y: 0, width: w, height: 160)) { element in
            guard let container = element as? UIView else { return }
            container.backgroundColor = UIColor.black
        }
        displayContainer.addUIElement(resultLabel, text: "0", frame: CGRect(x: 70, y: 70, width: w-70, height: 90)) {
            element in
            guard let label = element as? UILabel else { return }
            label.textColor = UIColor.white
            label.font = UIFont(name: label.font.fontName, size: 60)
            label.textAlignment = NSTextAlignment.right
        }
        
        let calcContainer = UIView()
        view.addUIElement(calcContainer, frame: CGRect(x: 0, y: 160, width: w, height: h-160)) { element in
            guard let container = element as? UIView else { return }
            container.backgroundColor = UIColor.black
        }
        
        let margin: CGFloat = 1.0
        let buttonWidth: CGFloat = w / 4.0
        let buttonHeight: CGFloat = 100.0
        
        // MARK: Top Row
        for (i, el) in others.enumerated() {
            let x = (CGFloat(i%3) + 1.0) * margin + (CGFloat(i%3) * buttonWidth)
            let y = (CGFloat(i/3) + 1.0) * margin + (CGFloat(i/3) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: el), text: el,
                                       frame: CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)) { element in
                                        guard let button = element as? UIButton else { return }
                                        button.addTarget(self, action: #selector(operatorPressed), for: .touchUpInside)
            }
        }
        // MARK: Second Row 3x3
        for (i, digit) in digits.enumerated() {
            let x = (CGFloat(i%3) + 1.0) * margin + (CGFloat(i%3) * buttonWidth)
            let y = (CGFloat(i/3) + 1.0) * margin + (CGFloat(i/3) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: digit), text: digit,
                                       frame: CGRect(x: x, y: y+101.0, width: buttonWidth, height: buttonHeight)) { element in
                                        guard let button = element as? UIButton else { return }
                                        button.addTarget(self, action: #selector(numberPressed), for: .touchUpInside)
            }
        }
        // MARK: Vertical Column of Operators
        for (i, el) in operators.enumerated() {
            let x = (CGFloat(3) + 1.0) * margin + (CGFloat(3) * buttonWidth)
            let y = (CGFloat(i) + 1.0) * margin + (CGFloat(i) * buttonHeight)
            calcContainer.addUIElement(CustomButton(content: el), text: el,
                                       frame: CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight)) { element in
                                        guard let button = element as? UIButton else { return }
                                        button.backgroundColor = UIColor.orange
                                        button.setTitleColor(UIColor.white, for: .normal)
                                        button.addTarget(self, action: #selector(operatorPressed), for: .touchUpInside)
            }
        }
        // MARK: Last Row for big 0 and .
        for (i, el) in special.enumerated() {
            let myWidth = buttonWidth * (CGFloat((i+1)%2) + 1.0) + margin * (CGFloat((i+1)%2))
            let x = (CGFloat(2*i) + 1.0) * margin + buttonWidth * (CGFloat(i*2))
            calcContainer.addUIElement(CustomButton(content: el), text: el,
                                       frame: CGRect(x: x, y: 405, width: myWidth, height: buttonHeight)) { element in
                                        guard let button = element as? UIButton else { return }
                                        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            }
        }
    }
    
}
