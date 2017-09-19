//
//  ResultViewController.swift
//  TipAssistant
//
//  Created by Дмитрий Коробов on 27.08.17.
//  Copyright © 2017 Дмитрий Коробов. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    
    //MARK: VS Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateTip()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setBorders()
    }
    
    
    //MARK: @IBOutlets
    
    @IBOutlet weak var tipSlider: UISlider!
    @IBOutlet weak var splitBillSlider: UISlider!
    
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipPercentLabel: UILabel!
    @IBOutlet weak var tipMaxPercentLabel: UILabel!
    @IBOutlet weak var splitBillLabel: UILabel!
    
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var costPerPersonLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var tipStackView: UIStackView!
    
    
    //MARK: Properties
    
    var questions: Questions = RestaurantQuestions()
    
    private let userDefaults = UserDefaults.standard
    
    private var currency: String {
        return userDefaults.string(forKey: UserDefaultsKeys.currency)!
    }
    
    private var formatter: NumberFormatter {
        get {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.roundingMode = .halfUp
            formatter.decimalSeparator = ","
            formatter.groupingSeparator = " "
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 2
            return formatter
        }
    }
    
    private var billAmountTextFieldText: String {
        get {
            return formatCurrencyString(billAmountTextField.text!)
        }
        set {
            billAmountTextField.text = newValue
            calculateSummary()
        }
    }
    
    private var tipPercentValue: Int {
        get {
            return Int(tipSlider.value)
        }
        set {
            tipSlider.value = Float(newValue)
            tipPercentLabel.text = "Tip: \(newValue)%"
            calculateSummary()
        }
    }
    
    private var tipMaxPercentText: String {
        get {
            return tipMaxPercentLabel.text!
        }
        set {
            tipSlider.maximumValue = Float(newValue)!
            tipMaxPercentLabel.text = newValue
        }
    }

    
    private var splitBillValue: Int {
        get {
            return Int(splitBillSlider.value)
        }
        set {
            splitBillLabel.text = "Split Bill: \(newValue)"
            calculateSummary()
        }
    }
    
    private var costLabelText: String {
        get {
            return formatCurrencyString(costLabel.text!)
        }
        set {
            costLabel.text = newValue
        }
    }
    
    private var tipLabelText: String {
        get {
            return formatCurrencyString(tipLabel.text!)
        }
        set {
            tipLabel.text = newValue
        }
    }
    
    private var resultLabelText: String {
        get {
            return formatCurrencyString(resultLabel.text!)
        }
        set {
            resultLabel.text = newValue
        }
    }
    
    private var costPerPersonLabelText: String {
        get {
            return costPerPersonLabel.text!
        }
        set {
            costPerPersonLabel.text = newValue
        }
    }
    
    
    //MARK: IBActions
    
    @IBAction func billAmountChanged(_ sender: UITextField) {
        let text = billAmountTextField.text
        if text != nil && text != "" {
            let value = formatter.number(from: text!)
            billAmountTextFieldText = formatter.string(from: value!)! + " \(currency)"
        }
        else {
            billAmountTextFieldText = "0"
        }
    }
    
    @IBAction func tipAmountChanged(_ sender: UISlider) {
        tipPercentValue = Int(sender.value)
    }
    
    @IBAction func splitBillValueChanged(_ sender: UISlider) {
        splitBillValue = Int(sender.value)
    }
    
    
    //MARK: Functions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func formatCurrencyString(_ string: String) -> String {
        let text = string.replacingOccurrences(of: currency, with: "")
        return (formatter.number(from: text)?.stringValue)!
    }
    
    private func calculateSummary() {
        costLabelText = formatter.string(from: NSNumber(value: Double(billAmountTextFieldText)!))! + " \(currency)"
        tipLabelText = formatter.string(from: NSNumber(value: (Double(costLabelText)! * Double(tipPercentValue) / 100)))! + " \(currency)"
        resultLabelText = formatter.string(from: NSNumber(value: Double(costLabelText)! + Double(tipLabelText)!))! + " \(currency)"
        costPerPersonLabelText = formatter.string(from: NSNumber(value: Double(resultLabelText)! / Double(splitBillValue)))! + " \(currency)"
    }
    
    private func setBorders() {
        billAmountTextField.layer.cornerRadius = 15
        billAmountTextField.layer.borderWidth = 0.5
        billAmountTextField.layer.borderColor = UIColor.white.cgColor
    }
    
    private func calculateTip() {
        tipMaxPercentText = userDefaults.string(forKey: UserDefaultsKeys.maxTipValue)!
        tipPercentValue = Int(tipSlider.maximumValue/2)
        
        let calculator = TipCalculator(questions: questions)
        tipPercentValue = calculator.calculateTip()
    }
}


//MARK: Extensions

extension CALayer {
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        let border = CALayer()
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: self.frame.width, height: thickness)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
            break
        default:
            break
        }
        border.backgroundColor = color.cgColor;
        self.addSublayer(border)
    }
}
