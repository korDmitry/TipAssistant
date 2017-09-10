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
    
    func calculateTip(withStartValue value:Int) -> Int {
        var result = value
        for question in questions.questionsArray {
            switch question.mark {
            case .exellent:
                result += 2
            case .good:
                result += 1
            case .bad:
                result -= 1
            default:
                break
            }
        }
        return result
    }
}
