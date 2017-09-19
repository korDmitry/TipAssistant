//
//  InformationViewController.swift
//  TipAssistant
//
//  Created by Дмитрий Коробов on 29.08.17.
//  Copyright © 2017 Дмитрий Коробов. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    
    //MARK: VC lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaults()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setBorders()
    }
    
    
    //MARK: IBOutlets
    
    @IBOutlet weak var establishmentSegmentedControl: UISegmentedControl!
    @IBOutlet weak var currencySegmentControl: UISegmentedControl!
    @IBOutlet weak var maxTipTextField: UITextField!
    @IBOutlet weak var languagePickerView: UIPickerView!
    
    
    //MARK: Properties
    
    fileprivate let userDefaults = UserDefaults.standard
    
    
    //MARK: @IBActions
    
    @IBAction func establishmentChanged(_ sender: UISegmentedControl) {
        let index = establishmentSegmentedControl.selectedSegmentIndex
        let title = establishmentSegmentedControl.titleForSegment(at: index)!
        userDefaults.set(title, forKey: UserDefaultsKeys.establishment)
    }
    
    @IBAction func currencyChanged(_ sender: UISegmentedControl) {
        let index = currencySegmentControl.selectedSegmentIndex
        let title = currencySegmentControl.titleForSegment(at: index)!
        userDefaults.set(title, forKey: UserDefaultsKeys.currency)
    }
    
    
    @IBAction func maxTipTextFieldWillChanged(_ sender: UITextField) {
        maxTipTextField.text = ""
        maxTipTextField.font = UIFont.systemFont(ofSize: 25.0, weight: UIFontWeightThin)
        maxTipTextField.textColor = UIColor.white
    }
    
    @IBAction func maxTipValueChanged(_ sender: UITextField) {
        
        let value = Int(maxTipTextField.text!)!
        
        if value >= 0 && value <= 100 {
            userDefaults.set(maxTipTextField.text, forKey: UserDefaultsKeys.maxTipValue)
        }
        else {
            let text = "Enter value from 0 to 100"
            let warning = NSAttributedString(string: text, attributes: [NSForegroundColorAttributeName : UIColor.red])
            maxTipTextField.font = UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightThin)
            maxTipTextField.attributedText = warning
        }
    }
    
    
    //MARK: Functions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func setDefaults() {
        
        let establishment = userDefaults.string(forKey: UserDefaultsKeys.establishment)
        if establishment == Establishments.restaurant {
            establishmentSegmentedControl.selectedSegmentIndex = 0
        }
        else if establishment == Establishments.cafe {
            establishmentSegmentedControl.selectedSegmentIndex = 1
        }
        else {
            establishmentSegmentedControl.selectedSegmentIndex = 2
        }
        
        let currency = userDefaults.string(forKey: UserDefaultsKeys.currency)
        if currency == Currencies.dollar {
            currencySegmentControl.selectedSegmentIndex = 0
        }
        else if currency == Currencies.euro {
            currencySegmentControl.selectedSegmentIndex = 1
        }
        else if currency == Currencies.pound {
            currencySegmentControl.selectedSegmentIndex = 2
        }
        else if currency == Currencies.rouble {
            currencySegmentControl.selectedSegmentIndex = 3
        }
        
        let maxTipValue = userDefaults.string(forKey: UserDefaultsKeys.maxTipValue)
        maxTipTextField.text = maxTipValue
        
        let language = userDefaults.string(forKey: UserDefaultsKeys.language)
        let row = languages.index(of: language!)!
        languagePickerView.selectRow(row, inComponent: 0, animated: false)
    }
    
    private func setBorders() {
        maxTipTextField.layer.cornerRadius = 15
        maxTipTextField.layer.borderWidth = 0.5
        maxTipTextField.layer.borderColor = UIColor.white.cgColor
    }
}


//MARK: Extensions

extension SettingsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let text = languages[row]
        
        let title = NSAttributedString(string: text, attributes: [
            NSFontAttributeName : UIFont.systemFont(ofSize: 25.0, weight: UIFontWeightThin),
            NSForegroundColorAttributeName : UIColor.white])
        
        let label = (view as? UILabel) ?? UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.attributedText = title
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let language = languages[row]
        userDefaults.set(language, forKey: UserDefaultsKeys.language)
    }
}
