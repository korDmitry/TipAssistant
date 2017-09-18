//
//  File.swift
//  TipAssistant
//
//  Created by Дмитрий Коробов on 17.09.17.
//  Copyright © 2017 Дмитрий Коробов. All rights reserved.
//

import Foundation

enum Establishments {
    static let restaurant = "Restaurant"
    static let bar = "Bar"
    static let cafe = "Cafe"
}

enum Currencies {
    static let dollar = "$"
    static let euro = "€"
    static let pound = "￡"
    static let rouble = "₽"
}

enum UserDefaultsKeys {
    static let establishment = "Establishment"
    static let currency = "Currency"
    static let maxTipValue = "MaxTipValue"
    static let language = "Language"
}

let languages: [String] = ["English", "Русский", "Español", "Deutsch"]
