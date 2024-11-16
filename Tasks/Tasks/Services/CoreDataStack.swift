//
//  CoreDataStack.swift
//  Tasks
//
//  Created by Aleksandr Bochkarev on 11/14/24.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    let persistentContainer: NSPersistentContainer
    let mainContext: NSManagedObjectContext
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Tasks")
        mainContext = persistentContainer.viewContext
        let description = persistentContainer.persistentStoreDescriptions.first
        // create persistentContainer in disc
        description?.type = NSSQLiteStoreType
        
        persistentContainer.loadPersistentStores { description, error in
            guard error == nil else {
                fatalError("was unable to load store \(error!)")
            }
        }
    }
}
