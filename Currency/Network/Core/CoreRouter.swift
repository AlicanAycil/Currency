//
//  CoreRouter.swift
//  Currency
//
//  Created by Alican Aycil on 28.11.2018.
//  Copyright © 2018 Alican Aycil. All rights reserved.
//

import Foundation
import Alamofire

public enum CoreRouter : URLRequestConvertible {
    
    static let baseUrl = "https://api.exchangeratesapi.io"
    
    case GetCurrencies()

    
    var method: Alamofire.HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .GetCurrencies():
            return "/latest"
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = URL(string: CoreRouter.baseUrl)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .GetCurrencies():
            return try Alamofire.JSONEncoding.default.encode(urlRequest)
        }
    }
}
