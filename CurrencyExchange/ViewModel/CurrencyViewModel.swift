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

private let defaultCurrencies: [Currency] = [
    Currency(name: "US dollar", rate: 1.0, symbol: "US", code: "USD"),
    Currency(name: "Canadian dollar", rate: 1.0, symbol: "CA", code: "CAD")
]

@propertyWrapper
struct UserDefaultValue<T:Codable> {
    let key: String
    let defaultValue: T
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    var wrappedValue: T {
        get {
            let data = UserDefaults.standard.data(forKey: key)
            let value = data.flatMap { try? JSONDecoder().decode(T.self, from: $0)}
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}

class CurrencyViewModel: ObservableObject {
    let currencies = supportedCurrencies
//    let labels = Currencies().currencyLabel
    var objectWillChange = PassthroughSubject<CurrencyViewModel,Never>()
    var binding = ObjectWillChangePublisher()
    @Published var isActiveField: Bool = false {
        didSet{
            objectWillChange.send(self)
        }
    }
    
    @Published var isAlert: Bool = false {
        didSet{
            objectWillChange.send(self)
        }
    }
    @Published var baseAmount: String = "0" {
        didSet{
            objectWillChange.send(self)
        }
    }
    @UserDefaultValue(key: "baseCurrency", defaultValue: defaultCurrencies[0])
    var baseCurrency: Currency {
        didSet{
            objectWillChange.send(self)
        }
    }
    
    @UserDefaultValue(key: "allCurrencies", defaultValue: defaultCurrencies)
    var allCurrencies: [Currency] {
        didSet {
            objectWillChange.send(self)
        }
    }
    @UserDefaultValue(key: "userCurrency", defaultValue: defaultCurrencies)
    var userCurrency: [Currency] {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    var showPicker : Bool = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    @Published var display : Bool = false {
        didSet{
            objectWillChange.send(self)
        }
    }
}
