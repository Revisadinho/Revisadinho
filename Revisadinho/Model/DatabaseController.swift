//
//  DatabaseController.swift
//  Revisadinho
//
//  Created by Hiago Chagas on 14/09/21.
//

import Foundation
import CoreData

class DatabaseController {
    var containerName: String = "revisadinhoContainer"
    var persistentContainer: NSPersistentContainer {
        return getPersistentContainer()
    }
    // MARK: - Core Data stack
    private func getPersistentContainer() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                // fatalError causes the application to generate a crash log and terminate.
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError causes the application to generate a crash log and terminate.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
