//
//  Persistence.swift
//  ChatApp
//
//  Created by Kavindu Dissanayake on 2022-12-23.
//

import CoreData

class PersistenceController {
    
    static let shared = PersistenceController()
    private init() {}
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ChatApp")
        container.loadPersistentStores(completionHandler: { _, error in
            _ = error.map { fatalError("Unresolved error \($0)") }
        })
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func backgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
}
