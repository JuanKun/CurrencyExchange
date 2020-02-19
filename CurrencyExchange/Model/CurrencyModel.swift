//
//  CurrencyModel.swift
//  CurrencyExchange
//
//  Created by Juansyah - on 19/02/20.
//  Copyright © 2020 Juansyah. All rights reserved.
//

import Foundation

enum Currency: String {
    case IDR = "IDR"
    case JPY = "JPY"
    case KRW = "KRW"
    case USD = "USD"
    case GBP = "GBP"
}

struct CurrencyModel: Codable {
    let base : String
    let date : String
    let rates : [Nominals]
}

struct Nominals: Codable{
    let IDR : Double
    let JPY : Double
    let KRW : Double
    let USD : Double
}
