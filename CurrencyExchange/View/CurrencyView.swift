//
//  ContentView.swift
//  CurrencyExchange
//
//  Created by Juansyah - on 15/02/20.
//  Copyright © 2020 Juansyah. All rights reserved.
//

import SwiftUI

struct CurrencyView: View {
    //Variables and Constants
    @ObservedObject var currencyVM = CurrencyViewModel()
    @State var currency1 : String = ""
    @State var currency2 : String = ""
    @State var isActiveField = false
    @State var selection1 = 2
    @State var selection2 = 1
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    private func dismissKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
        self.isActiveField.toggle()
    }
    
    private func dismissPicker(){
//        if currencyVM.showPicker1 == true || currencyVM.showPicker2 == true {
            self.currencyVM.showPicker1 = false
            self.currencyVM.showPicker2 = false
//        }
    }
    
    var body: some View {
        VStack{
            Spacer().frame(height: screenHeight*0.03)
            Image("currencyLogo").resizable().frame(width: screenWidth*0.5, height: screenHeight*0.3, alignment: .center).foregroundColor(.blue)
//            Text("Welcome to CURREX").foregroundColor(.orange).font(.headline)
            Spacer().frame(height: screenHeight*0.07)
            HStack{
                Spacer()
                //BaseCurrencyLabel
                HStack{
                    Text("\(currencyVM.currencies[selection1])").onTapGesture {
                        self.currencyVM.showPicker1.toggle()
                        self.currencyVM.showPicker2 = false
                        if self.isActiveField == true{
                            self.dismissKeyboard()
                        }
                    }
                }.foregroundColor(self.currencyVM.showPicker1 ? .red : .blue ).frame(width: screenWidth*0.4)
                Spacer()
//                Image(systemName: "arrow.clockwise.circle").frame(width: screenWidth*0.1, height: screenHeight*0.05).foregroundColor(.orange).onTapGesture {
//                    let temp = self.selection1
//                    self.selection1 = self.selection2
//                    self.selection2 = temp
//                }
                Spacer()
                //ResultCurrencyLabel
                HStack{
                    Text("\(currencyVM.currencies[selection2])").onTapGesture {
                        self.currencyVM.showPicker2.toggle()
                        self.currencyVM.showPicker1 = false
                        if self.isActiveField == true{
                            self.dismissKeyboard()
                        }
                    }
                }.foregroundColor(self.currencyVM.showPicker2 ? .red : .blue ).frame(width: screenWidth*0.4)
                Spacer()
            }
            Spacer().frame(height: screenHeight*0.0005)
            HStack{
                Spacer()
                //BaseCurrency
                TextField("\(currencyVM.baseCurrency)",
                    text: $currency1,
                    onEditingChanged:  {_ in
                        self.isActiveField.toggle()
                        if self.currencyVM.showPicker1 == true || self.currencyVM.showPicker2 == true {
                            self.dismissPicker()
                        }
                }).keyboardType(.numberPad).textFieldStyle(RoundedBorderTextFieldStyle()).frame(width: screenWidth*0.35)
                Spacer()
                Image(systemName: "equal").frame(width: screenWidth*0.1, height: screenHeight*0.05)
                Spacer()
                //ResultCurrency
                TextField("\(currencyVM.resultCurrency)",
                    text: $currency2,
                    onEditingChanged:  {_ in
                        self.isActiveField.toggle()
                        if self.currencyVM.showPicker1 == true || self.currencyVM.showPicker2 == true {
                            self.dismissPicker()
                        }
                    }).keyboardType(.numberPad).textFieldStyle(RoundedBorderTextFieldStyle()).frame(width: screenWidth*0.35)
                Spacer()
            }.frame(height: screenHeight*0.1)
            Spacer()
            
            
            //ShowingPickers
            if currencyVM.showPicker1 {
                CurrencyPicker(selection: $selection1)
                    .onTapGesture {
                        self.currencyVM.showPicker1.toggle()
                }
            }
            if currencyVM.showPicker2 {
                CurrencyPicker(selection: $selection2)
                    .onTapGesture {
                        self.currencyVM.showPicker2.toggle()
                }
            }
        }.onTapGesture {
            if self.isActiveField == true{
                self.dismissKeyboard()
            }
        }
    }
}
struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView()
    }
}
