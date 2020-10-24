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
    //    @NSManaged var productNameAr : String
    var productImage: String = ""
  
    init(json: JSON){
        productNameEn = json["name_en"].stringValue
        //          productNameAr = json["name_ar"].stringValue
        
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
//    func productsFromDataStore(productsDataStore:
//    [ProductDataStore]) -> [Product] {
//        var products = [Product]()
//        for productDataStore in productsDataStore
//        {
//            let product = Product()
//            product.productNameEn = productDataStore.productNameEn
//            product.productImage = productDataStore.productImage
//            products.append(product)
//        }
//        return products
//    }

//    //
//    enum CodingKeys: String, CodingKey {
//        case productNameEn
//        case productNameAr
//        case productImage
//
//    }
//
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(productNameEn, forKey: .productNameEn)
//        //        try container.encode(productNameAr, forKey: .productNameAr)
//        try container.encode(productImage, forKey: .productImage)
//    }
//
//    //
//    required convenience init(from decoder: Decoder) throws {
//        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.context,
//            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
//            let entity = NSEntityDescription.entity(forEntityName: "ProductEntity", in: managedObjectContext) else {
//                fatalError("Failed to decode User")
//        }
//
//        self.init(entity: entity, insertInto: managedObjectContext)
//
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        productNameEn = try container.decode(String.self, forKey: .productNameEn)
//        //        productNameAr = try container.decode(String.self, forKey: .productNameAr)
//        productImage = try container.decode(String.self, forKey: .productImage)
//
//    }
//
//
}

//extension CodingUserInfoKey {
//    static let context = CodingUserInfoKey(rawValue: "context")
//}
