//
//  ResultViewController.swift
//  TipAssistant
//
//  Created by Дмитрий Коробов on 27.08.17.
//  Copyright © 2017 Дмитрий Коробов. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    //MARK: @VS lifecycle
    
    override func viewDidLoad() {
        billAmountTextField.layer.cornerRadius = 15
        billAmountTextField.layer.borderWidth = 0.5
        billAmountTextField.layer.borderColor = UIColor.white.cgColor
    }
    
    
    //MARK: @IBOutlets
    
    @IBOutlet weak var TipSlider: UISlider!
    @IBOutlet weak var splitBillSlider: UISlider!
    
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var splitBillLabel: UILabel!
    
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var costPerPersonLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    
    //MARK: Properties
    
    var questions = Questions()
    
    
    //MARK: IBActions
    
    @IBAction func billAmountChanged(_ sender: UITextField) {
        let text = billAmountTextField.text
        if text != nil && text != "" {
            costLabel.text = text
        }
        else {
            costLabel.text = "0"
        }
    }
    
    
    
    //MARK: Functions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
