//
//  Product.swift
//  CashUTask
//
//  Created by Anas on 10/19/20.
//  Copyright © 2020 Anas. All rights reserved.
//

import Foundation
import SwiftyJSON
struct Product {
    var productNameEn : String
    var productImage: String = ""
    var productNameAr : String
     init?(json: JSON) {
        productNameEn = json["name_en"].stringValue
        productNameAr = json["name_ar"].stringValue
        if let linksList = json["Links"].array {
            for imageLink in linksList {
                productImage = imageLink["link"].stringValue
            }
        }

          
       }
}
