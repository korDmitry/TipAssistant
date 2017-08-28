//
//  QuestionsViewController.swift
//  TipAssistant
//
//  Created by Дмитрий Коробов on 27.08.17.
//  Copyright © 2017 Дмитрий Коробов. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    //MARK: VC lifecycle
    
    override func viewDidLoad() {
        setNavigationBar()
        setBorders()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: @IBOutlets
    @IBOutlet weak var exellentButton: UIButton!
    @IBOutlet weak var goodButton: UIButton!
    @IBOutlet weak var neutralButton: UIButton!
    @IBOutlet weak var badButton: UIButton!
    
    //MARK: Private functions
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    private func setBorders() {
        exellentButton.layer.cornerRadius = 40
        exellentButton.layer.borderColor = UIColor.white.cgColor
        exellentButton.layer.borderWidth = 0.5
        exellentButton.clipsToBounds = true
        
        goodButton.layer.cornerRadius = 40
        goodButton.layer.borderColor = UIColor.white.cgColor
        goodButton.layer.borderWidth = 0.5
        goodButton.clipsToBounds = true
        
        neutralButton.layer.cornerRadius = 40
        neutralButton.layer.borderColor = UIColor.white.cgColor
        neutralButton.layer.borderWidth = 0.5
        neutralButton.clipsToBounds = true
        
        badButton.layer.cornerRadius = 40
        badButton.layer.borderColor = UIColor.white.cgColor
        badButton.layer.borderWidth = 0.5
        badButton.clipsToBounds = true
    }
}

