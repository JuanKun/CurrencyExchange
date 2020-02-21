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
    func didFailWithError(error: Error)
}

struct Currencies {
    
    var delegate : CurrenciesDelegate?
    let currencyArr = [Currency.IDR.rawValue,Currency.JPY.rawValue,Currency.KRW.rawValue,Currency.USD.rawValue,Currency.GBP.rawValue]
    let currencyLabel = ["Rp","¥","₩","$","£"]
    
    func CurrencyFetching(currency: String){
        let baseURL = "https://api.exchangerate-api.com/v4/latest/\(currency)"
        
        if let url = URL(string: baseURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
            }
        }
        
    }

}
