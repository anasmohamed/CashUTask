//
//  ProductWebService.swift
//  CashUTask
//
//  Created by Anas on 10/19/20.
//  Copyright © 2020 Anas. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON



protocol ProductAPIServiceProtocol {
    func fetchProducts( complete: @escaping ( _ success: Bool, _ photos: [Product]?, _ error: AFError? )->() )
}

class ProductAPIService :ProductAPIServiceProtocol{
    
    
    func fetchProducts(complete: @escaping (Bool, [Product]?, AFError?) -> ()) {
        AF.request(ServiceConstants.baseURL).responseJSON { response in
            debugPrint(response)
            
            if let response = response.data {
                print("Response Data: \(response)")
            } else {
                print("Response Data: nil")
            }
            if let request = response.request {
                print("Request Request: \(request)")
                print("Request Description: \(request.description)")
                print("Request Debug Description: \(request.debugDescription)")
                
                print("Response Request HTTP method: \(request.httpMethod!)")
                //                print("Response Request Content-Type: \(request.value(forHTTPHeaderField: NetworkingConstants.contentType)!)")
            } else {
                print("Response Request: nil")
            }
            
            if let responseStatusCode = response.response {
                print("Response Status Code: \(responseStatusCode.statusCode)")
            } else {
                print("Response Status Code: nil")
            }
            
            if let error = response.error {
                print("Response Error Code: \(error.localizedDescription)")
            } else {
                print("Response Error Code: nil")
            }
            //   print(response.value!)
            let result = response.result
            switch result {
            case .success :
                let json = JSON(response.value!)
                print(json)
                var productsList = [Product]()
                let products = json["data"]["products"].arrayValue
                
                for product in products
                {
                    let productData = Product()
                    productData.parseProductJsonObject(json: product)
                    productsList.append(productData)
                    
                }
                complete(true,productsList,nil)
                
                
            case .failure(let error):
                
                complete(false,nil,error)
            }
        }
    }
    
    
    
    func getProducts(completion: @escaping ([Product]?)->Void ) {
        
        
    }
    
}

