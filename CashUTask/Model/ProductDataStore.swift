//
//  ProductEntity.swift
//  CashUTask
//
//  Created by Anas on 10/24/20.
//  Copyright © 2020 Anas. All rights reserved.
//

import Foundation
import CoreData
import SDWebImage
public class ProductDataStore{
    
    
    func saveProductIntoCoreData(products:[Product])  {
//        CoreDataStorage.shared.clearStorage(forEntity: "ProductEntity")
        let managedContext =
            CoreDataStorage.shared.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName: "ProductEntity",
                                       in: managedContext)!
        for product in products{
        let productEntity = NSManagedObject(entity: entity,
                                            insertInto: managedContext)
        
            SDWebImageManager.shared.imageLoader.requestImage(with: URL( string: product.productImage  ), options: SDWebImageOptions.highPriority, context: nil, progress: nil){
                
                (downloadedImage, downloadException, cacheType, downloadURL) in
               // create NSData from UIImage
                
                let imageData = downloadedImage!.jpegData(compressionQuality: 1)
                productEntity.setValue(imageData, forKeyPath: "productImage")
                productEntity.setValue(product.productNameEn, forKeyPath: "productNameEn")

                
            }
        
        }
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
                product.savedImage = (data.value(forKey: "productImage") as? NSData)!

                product.productNameEn = data.value(forKey: "productNameEn") as! String

                fetchedProducts.append(product)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return fetchedProducts
    }
}
