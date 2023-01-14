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

extension PersistenceController {
    @discardableResult
    func saveUserData(with user: User) -> LocalUserData? {
        let context = PersistenceController.shared.backgroundContext()
        let entity = LocalUserData.entity()
        let userData = LocalUserData(entity: entity, insertInto: context)
        userData.id = Int16(user.id ?? 0)
        userData.name = user.name
        userData.accessToken = user.accessToken
        userData.email = user.email
        userData.phone = user.phone
        userData.address = user.address
        userData.dob = user.dob
        userData.gender = user.gender
        userData.roles = user.roles
        do {
            try context.save()
            return userData
        } catch let error {
            print("Error: \(error)")
        }
        return nil
    }
    
    func updateUserData(with user: User) {
        let context = PersistenceController.shared.backgroundContext()
        let fetchRequest: NSFetchRequest<LocalUserData> = LocalUserData.fetchRequest()
        
        do {
            guard let userData = try context.fetch(fetchRequest).first else { return }
            
            userData.id = Int16(user.id ?? 0)
            userData.name = user.name
            userData.accessToken = user.accessToken
            userData.email = user.email
            userData.phone = user.phone
            userData.address = user.address
            userData.dob = user.dob
            userData.gender = user.gender
            userData.roles = user.roles
            do {
                try context.save()
            } catch let error {
                print("Error: \(error)")
            }
        } catch let error {
            print("Error: \(error)")
        }
    }
    
    func deleteUserData() {
        let context = PersistenceController.shared.backgroundContext()
        let fetchRequest: NSFetchRequest<LocalUserData> = LocalUserData.fetchRequest()
        
        do {
            let userData = try context.fetch(fetchRequest)
            userData.forEach{ context.delete($0) }
            
            do {
                try context.save()
            } catch let error {
                print("Error: \(error)")
            }
        } catch let error {
            print("Error: \(error)")
        }
    }
}
