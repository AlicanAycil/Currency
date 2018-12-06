//
//  CurrencyModel.swift
//  Currency
//
//  Created by Alican Aycil on 28.11.2018.
//  Copyright © 2018 Alican Aycil. All rights reserved.
//

import Foundation
import ObjectMapper

struct Rate {
    var Title: String?
    var Value: Double?
    var isUp: Bool?
    
    init (title: String?, value: Double?, isUp: Bool?) {
        self.Title = title
        self.Value = value
        self.isUp = isUp
    }
}

class CurrencyModel : Mappable {
    
    var Date: String!
    var Rates = [Rate]()
    var RatesDictionary = [String: Double]()
    var Base: String!
    
    init() {
    }
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        Date                <- map["date"]
        RatesDictionary     <- map["rates"]
        Base                <- map["base"]
        
        if Date == nil {
            Date = ""
        }
        
        if Base == nil {
            Base = ""
        }
    }
}
