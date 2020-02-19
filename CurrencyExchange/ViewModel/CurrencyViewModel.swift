//
//  CurrencyViewModel.swift
//  CurrencyExchange
//
//  Created by Juansyah - on 15/02/20.
//  Copyright © 2020 Juansyah. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class CurrencyViewModel: ObservableObject {
    @Published var curString : String = ""
    let currencies = Currencies().currencyArr
    let labels = Currencies().currencyLabel
    var objectWillChange = ObservableObjectPublisher()
    
    var baseCurrency : Double = 0 {
        willSet{
            self.objectWillChange.send()
        }
    }
    
    var resultCurrency : Double =  0 {
        willSet{
            self.objectWillChange.send()
        }
    }
    
    var showPicker1 : Bool = false {
        didSet {
            self.objectWillChange.send()
        }
    }
    
    var showPicker2 : Bool = false {
           didSet {
               self.objectWillChange.send()
           }
       }
    
}
