//
//  CoreDataStorage.swift
//  CashUTask
//
//  Created by Anas on 10/24/20.
//  Copyright © 2020 Anas. All rights reserved.
//

import UIKit
import CoreData

class CoreDataStorage: NSObject {
    static let shared = CoreDataStorage()
    private override init() {
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        objc_sync_enter(self)

        let container = NSPersistentContainer(name: "CashUTask")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        objc_sync_exit(self)

        return container
    }()
    
    func managedObjectContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func clearStorage(forEntity entity: String) {
        let isInMemoryStore = persistentContainer.persistentStoreDescriptions.reduce(false) {
            return $0 ? true : $1.type == NSInMemoryStoreType
        }

        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        // NSBatchDeleteRequest is not supported for in-memory stores
        if isInMemoryStore {
            do {
                let entities = try managedObjectContext.fetch(fetchRequest)
                for entity in entities {
                    managedObjectContext.delete(entity as! NSManagedObject)
                }
            } catch let error as NSError {
                print(error)
            }
        } else {
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try managedObjectContext.execute(batchDeleteRequest)
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
  
}
