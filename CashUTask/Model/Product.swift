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
    var prductName : String
    var productImage: String
     init?(json: JSON) {
        prductName = json["name_en"].stringValue
        productImage = json["link"].stringValue
           
           
          
       }
}
