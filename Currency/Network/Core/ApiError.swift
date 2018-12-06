//
//  ApiError.swift
//  Currency
//
//  Created by Alican Aycil on 28.11.2018.
//  Copyright © 2018 Alican Aycil. All rights reserved.
//

import Foundation

enum ApiError: Error {
    
    struct Code {
        var code: Int?
        var description: String?
    }
    case fail(Int?, description: String?)
    
    var handle: Code {
        switch self {
        case .fail(var num, var desc):
            if num == nil  {
                num = 0
            }
            
            if desc == nil {
                desc = "Error"
            }
            return Code(code: num, description: desc)
        }
    }
}
