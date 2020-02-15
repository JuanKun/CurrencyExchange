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
    @State var currency1 : String = ""
    @State var currency2 : String = ""
    @State var actCurOne : Bool = false
    @State var actCurTwo : Bool = false
    
    let currencyVM = CurrencyViewModel()
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        VStack{
            Spacer().frame(height: screenHeight*0.15)
            Image("currencyLogo").frame(width: screenWidth*0.15, height: screenHeight*0.15, alignment: .center).foregroundColor(.blue)
            Spacer().frame(height: screenHeight*0.15)
            HStack{
                Spacer()
                HStack{
                    Text("₩ KRW")
                }
                Spacer()
                Image(systemName: "arrow.clockwise.circle").frame(width: screenWidth*0.1, height: screenHeight*0.05).foregroundColor(.orange).onTapGesture {
                    print("change the currency")
                    
                }
                Spacer()
                HStack{
                    Text("$ USD")
                }
                Spacer()
            }
            Spacer().frame(height: screenHeight*0.0005)
            HStack{
                Spacer()
                TextField("0", text: $currency1).textFieldStyle(RoundedBorderTextFieldStyle()).frame(width: screenWidth*0.35, height: screenHeight*0.5)
                Spacer()
                Image(systemName: "equal").frame(width: screenWidth*0.1, height: screenHeight*0.05)
                Spacer()
                TextField("0", text: $currency2).textFieldStyle(RoundedBorderTextFieldStyle()).frame(width: screenWidth*0.35, height: screenHeight*0.5)
                Spacer()
            }.frame(height: screenHeight*0.1)
            Spacer()
        }
    }
}
struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView()
    }
}
