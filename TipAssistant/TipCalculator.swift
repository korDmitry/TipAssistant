//
//  TipCalculator.swift
//  TipAssistant
//
//  Created by Дмитрий Коробов on 09.09.17.
//  Copyright © 2017 Дмитрий Коробов. All rights reserved.
//

import Foundation

struct TipCalculator {
    
    var questions: Questions
    
    func calculateTip() -> Int {
        
        let questionsCount = questions.questionsArray.count
        let imaginaryTopBorder = 20.0
        var result = imaginaryTopBorder/2
        let bigStep = (imaginaryTopBorder-result)/Double(questionsCount)
        let smallStep = bigStep/2

        for question in questions.questionsArray {
            switch question.mark {
            case .exellent:
                result += bigStep
            case .good:
                result += smallStep
            case .bad:
                result -= bigStep
            default:
                break
            }
        }
        let a = Int(round(result))
        return a
    }
}
