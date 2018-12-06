//
//  LatestFactory.swift
//  Currency
//
//  Created by Alican Aycil on 28.11.2018.
//  Copyright © 2018 Alican Aycil. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire
import AlamofireObjectMapper

class LastestFactory {
    class func getCurrencies() -> Promise<CurrencyModel>  {
        return Promise { seal in
            Alamofire.request(CoreRouter.GetCurrencies()).validate().responseObject { (response: DataResponse<CurrencyModel>) in
                switch response.result {
                case .success(_):
                    let result = response.result.value
                    seal.fulfill(result!)
                case .failure(_):
                    seal.reject(ApiError.fail(response.response?.statusCode, description: BaseFactory.getErrorMessageAsString(data: response.data)))
                }
            }
        }
    }
}
