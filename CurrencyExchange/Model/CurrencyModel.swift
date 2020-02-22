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

struct CurrencyModel: Codable{
    let base : String
    let date : String
    let rates: [String:Double]
}

struct Currenci: Codable, Equatable, Identifiable {
    let id : UUID
    let name : String
    let rate: Double
    
    init(id: UUID, name: String, rate: Double) {
        self.id = UUID()
        self.name = name
        self.rate = rate
    }
}

let supportedCurrencies: [String: String] = [
    "THB": "Thai baht",
    "PHP": "Philippine peso",
    "CZK": "Czech koruna",
    "BRL": "Brazilian real",
    "CHF": "Swiss franc",
    "INR": "Indian rupee",
    "ISK": "Icelandic króna",
    "HRK": "Croatian kuna",
    "PLN": "Polish złoty",
    "NOK": "Norwegian krone",
    "USD": "US Dollar",
    "CNY": "Chinese Renminbi",
    "RUB": "Russian ruble",
    "SEK": "Swedish krona",
    "MYR": "Malaysian ringgit",
    "SGD": "Singapore dollar",
    "ILS": "Israeli new shekel",
    "TRY": "Turkish lira",
    "BGN": "Bulgarian lev",
    "NZD": "New Zealand dollar",
    "HKD": "Hong Kong dollar",
    "RON": "Romanian leu",
    "EUR": "Euro",
    "MXN": "Mexican peso",
    "CAD": "Canadian Dollar",
    "AUD": "Australian dollar",
    "GBP": "Pound sterling",
    "KRW": "South Korean won",
    "IDR": "Indonesian rupiah",
    "JPY": "Japanese yen",
    "DKK": "Danish krone",
    "ZAR": "South African rand",
    "HUF": "Hungarian forint"
]
