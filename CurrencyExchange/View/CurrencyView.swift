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
    @ObservedObject var binding = CurrencyViewModel()
    @State var lastUpdated = ""
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    private func dismissKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
        self.binding.isActiveField = false
        if self.binding.baseAmount == "" {
            self.binding.baseAmount = "0"
        }
    }
    
    private func dismissPicker(){
        self.currencyVM.showPicker = false
    }
    let inset = EdgeInsets(top: -8, leading: -20, bottom: -7, trailing: 5)
    
    var body: some View {
//        return let doubleValue :Double = Double(self.$baseAmount.wrappedValue) ?? 0.0
        GeometryReader{geomtry in
            ZStack{
                VStack{
                    //Titles
                    Spacer().frame(height: self.screenWidth*0.01)
                    HStack{
                        Spacer().frame(width: self.screenWidth*0.02)
                        Image(systemName: "coloncurrencysign.square.fill").resizable().frame(width: self.screenWidth*0.06, height: self.screenWidth*0.06).foregroundColor(.purple)
                        Text("Currex").font(.largeTitle).fontWeight(.bold).foregroundColor(.purple)
                        Spacer()
                    }
                    Spacer().frame(height: self.screenHeight*0.03)
                    //BASE-CURRENCY
                    HStack{
                        Spacer().frame(width: self.screenWidth*0.02)
                        Text("Base Currency").fontWeight(.semibold)
                        Spacer()
                    }
                    HStack{
                        Text(self.currencyVM.baseCurrency.flag).padding()
                        VStack(alignment: .leading){
                            Text(self.currencyVM.baseCurrency.code).foregroundColor(.white)
                            Text(self.currencyVM.baseCurrency.name).foregroundColor(.white)
                        }
                        Spacer()
                        TextField(self.binding.baseAmount, text: self.$binding.baseAmount, onEditingChanged: { _ in
                            self.binding.isActiveField.toggle()
                            if self.binding.baseAmount == "0"{
                                self.binding.baseAmount = ""
                            }
                        }, onCommit: {
                            print("Masih Ketik")
                        }).foregroundColor(.white).multilineTextAlignment(.trailing).keyboardType(.numberPad)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundColor(.clear)
                                    .border(Color.init(.white))
                        ).frame(width: self.screenWidth*0.3).padding()
                    }.background(
                        Color.init(.purple)
                    )
                    Spacer().frame(height: self.screenHeight*0.02)
                    //RESULT-CURRENCY
                    HStack{
                        Spacer().frame(width: self.screenWidth*0.02)
                        Text("Result Currency").fontWeight(.semibold)
                        Spacer()
                    }
                    Spacer()
                    ScrollView {
                    // TODO: should filter out BaseCurrency from list
                        ForEach(self.currencyVM.allCurrencies) { currency in
                            CurrencyItemView(currency: currency, baseAmount: Double(self.$binding.baseAmount.wrappedValue) ?? 0.0).onTapGesture {
                                // Swap this and base
                                self.currencyVM.baseCurrency = currency
                                self.binding.isAlert.toggle()
                            }.alert(isPresented: self.$binding.isAlert) {
                                Alert(title: Text(""), message: Text("Base currency changed to: \n \(self.currencyVM.baseCurrency.name)"), dismissButton: .default(Text("OK")))
                            }
                        }.listStyle(GroupedListStyle())
                    }
                    
                    HStack{
                        Spacer().frame(width: self.screenWidth*0.02)
                        Text("Updated in : " + "\(self.lastUpdated)").font(.headline).foregroundColor(.purple)
                        Spacer()
                    }
                }
            }.onTapGesture {
                self.dismissKeyboard()
            }.onAppear{
                self.loadCurrencies()
                print(self.currencyVM.allCurrencies)
            }
        }
    }
    
    private func loadCurrencies() {
            // Check if last updated is the same date
            // if not the same pull from remote with base currency
            let url = URL(string: "https://api.exchangeratesapi.io/latest?base=USD")!

            let task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in
                if let data = data {
                    if let decoded: CurrencyModel = self.decodeData(CurrencyModel.self, data){
                        //
                        self.lastUpdated = decoded.date
                        
                        // generate currency data
                        var newCurrencies = [Currency]()
                        for key in decoded.rates.keys {
                            let newCurrency = Currency(name: supportedCurrencies[key]?[0] ?? "Unknown", rate: 1.0 / (decoded.rates[key] ?? 1.0), symbol: supportedCurrencies[key]?[1] ?? "", code: key)
                            if
                            newCurrency.code == Currencee.THB.rawValue ||
                            newCurrency.code == Currencee.CNY.rawValue ||
                            newCurrency.code == Currencee.JPY.rawValue ||
                            newCurrency.code == Currencee.SGD.rawValue ||
                            newCurrency.code == Currencee.PHP.rawValue ||
                            newCurrency.code == Currencee.MYR.rawValue ||
                            newCurrency.code == Currencee.KRW.rawValue ||
                            newCurrency.code == Currencee.IDR.rawValue {
                                newCurrencies.append(newCurrency)
                            }
                        }
                        
                        DispatchQueue.main.async {
                            self.currencyVM.allCurrencies = newCurrencies
                            if let base = self.currencyVM.allCurrencies.filter({ $0.symbol == self.currencyVM.baseCurrency.symbol }).first {
                                self.currencyVM.baseCurrency = base
                            }
                            var tempNewUserCurrency = [Currency]()
                            let userCurrencies = self.currencyVM.userCurrency.map{$0.code }
                            for c in self.currencyVM.allCurrencies {
                                if userCurrencies.contains(c.code){
                                    tempNewUserCurrency.append(c)
                                }
                            }
                            self.currencyVM.userCurrency = tempNewUserCurrency
                        }
                    }
                }
            })
            task.resume()
        }
}

extension CurrencyView {
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


struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView()
    }
}
