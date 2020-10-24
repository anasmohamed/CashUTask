//
//  Product.swift
//  CashUTask
//
//  Created by Anas on 10/19/20.
//  Copyright © 2020 Anas. All rights reserved.
//

import Foundation
import SwiftyJSON

class Product {
    var productNameEn : String = ""
    var productImage: String = ""
    var savedImage : NSData = NSData()
    init(json: JSON){
        productNameEn = json["name_en"].stringValue
        
        if let linksList = json["Links"].array {
            for imageLink in linksList {
                productImage = imageLink["link"].stringValue
            }
            if linksList.count == 0
            {
                productImage = json["Category"]["Link"]["link"].stringValue
            }
        }
    }
    init() {
        
    }
}
