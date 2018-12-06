//
//  CurrencyViewModel.swift
//  Currency
//
//  Created by Alican Aycil on 29.11.2018.
//  Copyright © 2018 Alican Aycil. All rights reserved.
//

import Foundation

struct CurrencyViewModel {
    
    weak var dataSource: DynamicValue<CurrencyModel>?
    
    init(dataSource : DynamicValue<CurrencyModel>?) {
        self.dataSource = dataSource
    }
    
    func fetchCurrencies(completion: @escaping ()-> Void = {}) {
        LastestFactory.getCurrencies()
            .done { currency -> Void in
                currency.Rates = self.returnRates(ratesDictionary: currency.RatesDictionary)
                self.dataSource?.value = currency
            }.catch { (error) in
                let error = error as! ApiError
                print(error.handle.description)
            }.finally {
                completion()
            }
    }
    
    func returnRates(ratesDictionary: [String: Double]!) -> [Rate] {
        var rates = [Rate]()
        for (key,value) in ratesDictionary {
            var isUp: Bool?
            if let oldRates = CurrencyHelper.shared.rates {
                if oldRates[key]! > value {
                    isUp = true
                } else if oldRates[key]! < value {
                    isUp = false
                } 
            }
            let rate = Rate(title: key, value: value, isUp: isUp)
            rates.append(rate)
        }
        CurrencyHelper.shared.setCurrencies(rates: ratesDictionary)
        return rates
    }
}
