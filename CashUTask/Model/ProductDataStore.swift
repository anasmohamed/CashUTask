//
//  ProductEntity.swift
//  CashUTask
//
//  Created by Anas on 10/24/20.
//  Copyright © 2020 Anas. All rights reserved.
//

import Foundation
import CoreData
public class ProductDataStore{
    
    
    func saveProductIntoCoreData(products:[Product])  {
        
        
        // 1
        let managedContext =
            CoreDataStorage.shared.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "ProductEntity",
                                       in: managedContext)!
        for product in products{
        let productEntity = NSManagedObject(entity: entity,
                                            insertInto: managedContext)
        
        // 3
        productEntity.setValue(product.productImage, forKeyPath: "productImage")
        //          productEntity.setValue(product.productNameEn, forKeyPath: "productNameAr")
        productEntity.setValue(product.productNameEn, forKeyPath: "productNameEn")
        
        }
        // 4
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchProductsFromCoreData() -> [Product] {
        
        var fetchedProducts = [Product]()
        
        
        let managedContext =
            CoreDataStorage.shared.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "ProductEntity")
        
        //3
        do {
           let result = try managedContext.fetch(fetchRequest)
            for data in result
            {
                let product = Product()
                product.productImage = data.value(forKey: "productImage") as! String
                
                product.productNameEn = data.value(forKey: "productNameEn") as! String
                
                fetchedProducts.append(product)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return fetchedProducts
    }
}
