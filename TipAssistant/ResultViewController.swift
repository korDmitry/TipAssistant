//
//  ResultViewController.swift
//  TipAssistant
//
//  Created by Дмитрий Коробов on 27.08.17.
//  Copyright © 2017 Дмитрий Коробов. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    
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
    
}
