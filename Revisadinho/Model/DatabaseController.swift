//
//  DatabaseController.swift
//  Revisadinho
//
//  Created by Hiago Chagas on 14/09/21.
//

import Foundation
import CoreData

public class DatabaseController {
    public static let shared = DatabaseController()
    private var containerName: String = "revisadinhoContainer"
    public let persistentContainer: NSPersistentContainer
    public let viewContext: NSManagedObjectContext
    
    private init() {
        let container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                // fatalError causes the application to generate a crash log and terminate.
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        persistentContainer = container
        viewContext = persistentContainer.viewContext
    }

}
