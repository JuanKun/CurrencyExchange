//
//  Currencies.swift
//  CurrencyExchange
//
//  Created by Juansyah - on 15/02/20.
//  Copyright © 2020 Juansyah. All rights reserved.
//

import Foundation
import SwiftUI

protocol CurrenciesDelegate {
    func didChangeCurrency(currency: String)
}
struct Currencies {
    
    var delegate : CurrenciesDelegate?
    let currencyArray = ["Rp IDR","¥ JPY","₩ KRW","$ USD"]
    
    
    
    func CurrencyFetching(currency: String){
        let baseURL = "https://api.exchangerate-api.com/v4/latest/\(currency)"
        
        
    }

}
