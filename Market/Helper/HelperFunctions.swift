//
//  HelperFunctions.swift
//  Market
//
//  Created by Dheeraj Arora on 14/11/19.
//  Copyright © 2019 Dheeraj Arora. All rights reserved.
//

import Foundation


func convertToCurrency(number: Double) -> String {
    let correncyFormatter = NumberFormatter()
    correncyFormatter.usesGroupingSeparator = true
    correncyFormatter.numberStyle = .currency
    correncyFormatter.locale = Locale(identifier: "en_IN")
    return correncyFormatter.string(from: NSNumber(value: number))!
}
