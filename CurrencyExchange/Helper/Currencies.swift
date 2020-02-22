//
//  Currencies.swift
//  CurrencyExchange
//
//  Created by Juansyah - on 15/02/20.
//  Copyright © 2020 Juansyah. All rights reserved.
//

import Foundation
import SwiftUI

//protocol CurrenciesDelegate {
//    func didChangeCurrency(currency: String)
//    func didFailWithError(error: Error)
//}

struct Currencies {
    
//    var delegate : CurrenciesDelegate?
    @EnvironmentObject var currencyVM : CurrencyViewModel
    let currencyArr = [Currency.IDR.rawValue,Currency.JPY.rawValue,Currency.KRW.rawValue,Currency.USD.rawValue,Currency.GBP.rawValue]
    let currencyLabel = ["Rp","¥","₩","$","£"]
    func CurrencyFetching(){
        let baseURL = "https://api.exchangeratesapi.io/latest?base=USD"
        
        if let url = URL(string: baseURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, _, _) in
                if let data = data{
                    if let decoded: CurrencyModel = self.decodeData(CurrencyModel.self, data){
                        self.currencyVM.lastUpdated = decoded.date
                        var newCurrencis = [Currenci]()
//                        for key in decoded.rates.keys {
//                            let newCurrenci = Currenci(name: supportedCurrencies[key]? [0] ?? "Unknown", rate: 1.0 / (decoded.rates[key] ?? 1.0))
//                            newCurrencis.append(newCurrenci)
//                        }
                        
//                        DispatchQueue.main.async {
//                            <#code#>
//                        }
                    }
                    
                }
            }
        }
        
    }
}

extension Currencies {
    private func decodeData<T>(_ decodeObject: T.Type, _ data: Data) -> T? where T: Codable
    {
        let decoder = JSONDecoder()
        do
        {
            return try decoder.decode(decodeObject.self, from: data)
        }
        catch let jsonErr
        {
            print("Error decoding Json ", jsonErr)
            return nil
        }
    }
}
