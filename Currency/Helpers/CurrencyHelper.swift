//
//  CurrencyHelper.swift
//  Currency
//
//  Created by Alican Aycil on 30.11.2018.
//  Copyright © 2018 Alican Aycil. All rights reserved.
//

import Foundation

class CurrencyHelper {
    static let shared = CurrencyHelper()
    
    func setCurrencies(rates: [String: Double]!) {
        let defaults = UserDefaults.standard
        defaults.setValue(rates, forKey: defaultsKeys.currencies)
        defaults.synchronize()
    }
    
    var rates: [String: Double]? {
        get {
            let defaults = UserDefaults.standard
            let value = defaults.value(forKeyPath: defaultsKeys.currencies)
            if value != nil {
                return value  as! [String: Double]
            }
            return nil
        }
    }
}

struct defaultsKeys {
    static let currencies = "currencies"

}
