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
    @Published var showPicker : Bool = false
    @Published var curString : String = ""
    @Published var isSheet1 : Bool = false
    @Published var isSheet2 : Bool = false
    
    let currencies = Currencies().currencyArray
    let objectWillChange = PassthroughSubject<CurrencyViewModel,Never>()
}
