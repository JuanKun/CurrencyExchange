//
//  CurrencyPicker.swift
//  CurrencyExchange
//
//  Created by Juansyah - on 15/02/20.
//  Copyright © 2020 Juansyah. All rights reserved.
//

import SwiftUI

struct CurrencyPicker: View {
//    @State var selection = ["Rp IDR","¥ JPY","₩ KRW","$ USD"]
    @State var currencyChoice = 0
    let currencyVM = CurrencyViewModel()
    var body: some View {
       Picker("", selection: $currencyChoice) {
        ForEach(0 ..< currencyVM.currencies.count) { index in
                Text(self.currencyVM.currencies[index])
                    .tag(index)
                }
        }.frame(width: UIScreen.main.bounds.width*0.5, height: UIScreen.main.bounds.height*0.1).pickerStyle(WheelPickerStyle())
    }
}

struct CurrencyPicker_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyPicker()
    }
}
