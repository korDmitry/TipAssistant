//
//  Question.swift
//  TipAssistant
//
//  Created by Дмитрий Коробов on 27.08.17.
//  Copyright © 2017 Дмитрий Коробов. All rights reserved.
//

import Foundation

struct Questions {
    var currentQuestion: Int = 0
    var questionsArray:[Question] = [Decoration(), FirstDish(), SecondDish(), Dessert(), Service()]
}

protocol Question {
    var text: String {get}
    var mark: Mark {get set}
}

struct Decoration: Question {
    let text: String = "Estimate the planting and decoration of the restaurant"
    var mark = Mark.none
}

struct Drinks: Question {
    let text: String = "Did you like the drinks?"
    var mark = Mark.none
}

struct FirstDish: Question {
    let text: String = "Did you like the first dish?"
    var mark = Mark.none
}

struct SecondDish: Question {
    let text: String = "What about the second dish?"
    var mark = Mark.none
}

struct Dessert: Question {
    let text: String = "Was the dessert delicious?"
    var mark = Mark.none
}

struct Service: Question {
    let text: String = "What about the general service?"
    var mark = Mark.none
}

enum Mark {
    case exellent
    case good
    case neutral
    case bad
    case none
}
