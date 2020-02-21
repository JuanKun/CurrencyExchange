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
    let currencies = Currencies().currencyArr
    let labels = Currencies().currencyLabel
    var objectWillChange = PassthroughSubject<CurrencyViewModel,Never>()
    
    @Published var lastUpdated : String = ""{
        didSet{
            objectWillChange.send(self)
        }
    }
    @Published var baseCurrency : String = String(0) {
        willSet{
            objectWillChange.send(self)
        }
    }
    @Published var resultCurrency : String = String(0) {
        willSet{
            objectWillChange.send(self)
        }
    }
    var showPicker1 : Bool = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    var showPicker2 : Bool = false {
           didSet {
               objectWillChange.send(self)
           }
    }
    
    @Published var display1 : Bool = false {
        didSet{
            objectWillChange.send(self)
        }
    }
    @Published var display2 : Bool = false {
        didSet{
            objectWillChange.send(self)
        }
    }
}
