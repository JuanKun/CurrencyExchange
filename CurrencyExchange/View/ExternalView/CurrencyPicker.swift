//
//  CurrencyPicker.swift
//  CurrencyExchange
//
//  Created by Juansyah - on 15/02/20.
//  Copyright © 2020 Juansyah. All rights reserved.
//

import SwiftUI

struct CurrencyPicker: View {
    @Binding var selection : Int
    @EnvironmentObject var currencyVM : CurrencyViewModel
    var body: some View {
        VStack {
//            Spacer()
            Text("Choose the currency")
            Picker("", selection: $selection) {
            ForEach(0 ..< currencyVM.currencies.count) { index in
                Text("\(self.currencyVM.labels[index])" + " " + "\(self.currencyVM.currencies[index])")
                        .tag(index)
                    }
                }.pickerStyle(WheelPickerStyle()).labelsHidden()
        }
    }
    
}

struct CurrencyPicker_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyPicker(selection: .constant(2))
    }
}
