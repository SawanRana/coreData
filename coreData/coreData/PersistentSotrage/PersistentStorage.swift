//
//  PersistentStorage.swift
//  coreData
//
//  Created by Sawan Rana on 12/01/23.
//

import Foundation
import CoreData

final class PersistentStorage {
    
    private init() {}
    
    static let shared = PersistentStorage()
    
    // MARK: - Core Data stack
    
    lazy var context = persistentContainer.viewContext

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "coreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            debugPrint("Core data -> \(storeDescription)")
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchManagedObject<T: NSManagedObject>(mangedObj: T.Type) -> [T] {
        do {
            guard let result = try PersistentStorage.shared.context.fetch(mangedObj.fetchRequest()) as? [T] else {
                return []
            }
            return result
        } catch let error {
            debugPrint("Error \(error.localizedDescription)")
        }
        return []
    }
}
