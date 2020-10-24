//
//  Product.swift
//  CashUTask
//
//  Created by Anas on 10/19/20.
//  Copyright © 2020 Anas. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreData

class Product:NSManagedObject,Codable {
    @NSManaged var productNameEn : String
    @NSManaged var productNameAr : String
    @NSManaged var productImage: String
    
    
    
    
    enum CodingKeys: String, CodingKey {
        case productNameEn
        case productNameAr
        case productImage
        
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(productNameEn, forKey: .productNameEn)
        try container.encode(productNameAr, forKey: .productNameAr)
        try container.encode(productImage, forKey: .productImage)
    }
    
    
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.context,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "ProductEntity", in: managedObjectContext) else {
                fatalError("Failed to decode User")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        productNameEn = try container.decode(String.self, forKey: .productNameEn)
        productNameAr = try container.decode(String.self, forKey: .productNameAr)
        productImage = try container.decode(String.self, forKey: .productImage)
        
    }
  
    
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}
extension Product {
    func parseProductJsonObject(json: JSON){
          productNameEn = json["name_en"].stringValue
          productNameAr = json["name_ar"].stringValue
          
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
}
