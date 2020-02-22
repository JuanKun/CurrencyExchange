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
    @EnvironmentObject var currencyVM : CurrencyViewModel
    @State var isActiveField = false
    @State var selection1 = 2
    @State var selection2 = 1
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    private func dismissKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
        self.isActiveField = false
        print(self.currencyVM.baseCurrency)
        print(self.currencyVM.resultCurrency)
    }
    
    private func dismissPicker(){
        self.currencyVM.showPicker1 = false
        self.currencyVM.showPicker2 = false
    }
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                VStack{
                    Spacer().frame(height: self.screenHeight*0.03)
                    Image("currencyLogo").resizable().frame(width: self.screenWidth*0.5, height: self.screenHeight*0.3, alignment: .center).shadow(radius: 10)
                    Spacer().frame(height: self.screenHeight*0.1)
                    HStack{
                        Spacer()
                        //BaseCurrencyLabel
                        HStack{
                            Text("\(self.currencyVM.labels[self.selection1])"+" "+"\(self.currencyVM.currencies[self.selection1])").onTapGesture {
                                self.currencyVM.showPicker1.toggle()
                                self.currencyVM.showPicker2 = false
                                if self.isActiveField == true{
                                    self.dismissKeyboard()
                                }
                            }
                        }.foregroundColor(self.currencyVM.showPicker1 ? .red : .blue ).frame(width: self.screenWidth*0.45)
                        Spacer()
                        //ResultCurrencyLabel
                        HStack{
                            Text("\(self.currencyVM.labels[self.selection2])"+" "+"\(self.currencyVM.currencies[self.selection2])").onTapGesture {
                                self.currencyVM.showPicker2.toggle()
                                self.currencyVM.showPicker1 = false
                                if self.isActiveField == true{
                                    self.dismissKeyboard()
                                }
                            }
                        }.foregroundColor(self.currencyVM.showPicker2 ? .red : .blue ).frame(width: self.screenWidth*0.45)
                        Spacer()
                    }
                    Spacer().frame(height: self.screenHeight*0.0005)
                    HStack{
                        Spacer()
                        //BaseCurrency
                        TextField("0",
                                  text: self.$currencyVM.baseCurrency,
                            onEditingChanged:  {_ in
                                if self.isActiveField == true {
                                    self.dismissKeyboard()
                                }
                                self.isActiveField.toggle()
                                if self.currencyVM.showPicker1 == true || self.currencyVM.showPicker2 == true {
                                    self.dismissPicker()
                                }
                        }).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle()).frame(width: self.screenWidth*0.35)
                        Spacer()
                        Image(systemName: "equal").frame(width: self.screenWidth*0.1, height: self.screenHeight*0.05)
                        Spacer()
                        //ResultCurrency
                        ZStack{
                            Rectangle().frame(width: self.screenWidth*0.35, height: self.screenHeight*0.05).foregroundColor(.secondary).cornerRadius(5).opacity(0.5)
                            Text("100000").frame(width: self.screenWidth*0.35)
                        }
//                        TextField("0",
//                                  text: self.$currencyVM.resultCurrency,
//                            onEditingChanged:  {_ in
//                                 if self.isActiveField == true {
//                                    self.dismissKeyboard()
//                                }
//                                self.isActiveField.toggle()
//                                if self.currencyVM.showPicker1 == true || self.currencyVM.showPicker2 == true {
//                                    self.dismissPicker()
//                                }
//                        }).keyboardType(.decimalPad).textFieldStyle(RoundedBorderTextFieldStyle()).frame(width: self.screenWidth*0.35)
                        Spacer()
                    }.frame(height: self.screenHeight*0.1)
                    Spacer()
                    Text("Last updated: " + self.currencyVM.lastUpdated).foregroundColor(.orange).bold()
                    
                }.onTapGesture {
                    if self.isActiveField == true || (self.currencyVM.showPicker1 == true || self.currencyVM.showPicker2 == true){
                        self.dismissKeyboard()
                        self.dismissPicker()
                    }
                }.onAppear{
                    print("KAKA")
                    print(self.currencyVM.lastUpdated)
                }
                //ShowingPickersInZStackedView
                if self.currencyVM.showPicker1 {
                    BottomSheet(display: self.$currencyVM.showPicker1){
                        CurrencyPicker(selection: self.$selection1)
                            .onTapGesture {
                                self.currencyVM.showPicker1.toggle()
                        }
                    }
                }
                if self.currencyVM.showPicker2 {
                    BottomSheet(display: self.$currencyVM.showPicker2){
                        CurrencyPicker(selection: self.$selection2)
                            .onTapGesture {
                                self.currencyVM.showPicker2.toggle()
                        }
                    }
                }
            }
        }
    }
}


struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView()
    }
}
