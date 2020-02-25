//
//  ResultCurrencyView.swift
//  CurrencyExchange
//
//  Created by Juansyah - on 22/02/20.
//  Copyright © 2020 Juansyah. All rights reserved.
//

import Foundation
import SwiftUI

struct CurrencyItemView: View {
    @EnvironmentObject var currencyVM: CurrencyViewModel
    let currency: Currency
    let baseAmount: Double
    var body: some View {
        let currency = self.currency
        let conversionRate = String(format: "%.2f", currency.rate / currencyVM.baseCurrency.rate)
        let totalAmount = String(format: "%.2f", Double(baseAmount) * ( currencyVM.baseCurrency.rate / currency.rate))

        return HStack{
            Text(currency.flag).font(.largeTitle).fontWeight(.bold)
            VStack(alignment: .leading){
                Text(currency.code).font(.headline).foregroundColor(.primary)
                Text(currency.name).font(.footnote).foregroundColor(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing){
                Text("\(totalAmount)")
                Text("1 \(currency.code) = \(conversionRate) \(currencyVM.baseCurrency.code)").foregroundColor(.secondary)
            }
        }
    }
}
