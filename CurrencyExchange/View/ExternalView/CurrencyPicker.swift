////
////  CurrencyPicker.swift
////  CurrencyExchange
////
////  Created by Juansyah - on 15/02/20.
////  Copyright © 2020 Juansyah. All rights reserved.
////
//
//import SwiftUI
//
//struct CurrencyPicker: View {
//    @Binding var selection : Int
//    @EnvironmentObject var currencyVM : CurrencyViewModel
//    var body: some View {
//        VStack {
//            let keys = self.currencyVM.currencies.map{$0.key}
//            let values = self.currencyVM.currencies.map{$0.value}
//            Text("Choose the currency")
//            Picker("", selection: $selection) {
//                ForEach(keys.indices) { (index) in
//                Text("\(self.currencyVM.currencies[index])")
//                        .tag(index)
//                    }
//                }.pickerStyle(WheelPickerStyle()).labelsHidden()
//        }
//    }
//    
//}
//
//struct CurrencyPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        CurrencyPicker(selection: .constant(2))
//    }
//}
