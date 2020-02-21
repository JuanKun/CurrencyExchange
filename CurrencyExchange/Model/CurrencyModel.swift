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
        self.id = id
        self.name = name
        self.rate = rate
    }
}

let supportedCurrencies: [String: [String]] = [
    "THB": ["Thai baht", "TH"],
    "PHP": ["Philippine peso", "PH"],
    "CZK": ["Czech koruna", "CZ"],
    "BRL": ["Brazilian real", "BR"],
    "CHF": ["Swiss franc", "CH"],
    "INR": ["Indian rupee", "IN"],
    "ISK": ["Icelandic króna", "IS"],
    "HRK": ["Croatian kuna", "HR"],
    "PLN": ["Polish złoty", "PL"],
    "NOK": ["Norwegian krone", "NO"],
    "USD": ["US Dollar", "US"],
    "CNY": ["Chinese Renminbi", "CN"],
    "RUB": ["Russian ruble", "RU"],
    "SEK": ["Swedish krona", "SE"],
    "MYR": ["Malaysian ringgit", "MY"],
    "SGD": ["Singapore dollar", "SG"],
    "ILS": ["Israeli new shekel", "IL"],
    "TRY": ["Turkish lira", "TR"],
    "BGN": ["Bulgarian lev", "BG"],
    "NZD": ["New Zealand dollar", "NZ"],
    "HKD": ["Hong Kong dollar", "HK"],
    "RON": ["Romanian leu", "RO"],
    "EUR": ["Euro", "EU"],
    "MXN": ["Mexican peso", "MX"],
    "CAD": ["Canadian Dollar", "CA"],
    "AUD": ["Australian dollar", "AU"],
    "GBP": ["Pound sterling", "GB"],
    "KRW": ["South Korean won", "KR"],
    "IDR": ["Indonesian rupiah", "ID"],
    "JPY": ["Japanese yen", "JP"],
    "DKK": ["Danish krone", "DK"],
    "ZAR": ["South African rand", "ZA"],
    "HUF": ["Hungarian forint", "HU"]
]
