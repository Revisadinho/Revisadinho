//
//  CoreDataTestStack.swift
//  RevisadinhoTests
//
//  Created by Hiago Chagas on 16/09/21.
//

import CoreData
import XCTest
@testable import Revisadinho

struct CoreDataTestStack {
    private let containerName: String = "Model"
    let persistentContainer: NSPersistentContainer
    let viewContext: NSManagedObjectContext

    init() {
        persistentContainer = NSPersistentContainer(name: containerName)
        let description = persistentContainer.persistentStoreDescriptions.first
        description?.type = NSInMemoryStoreType
        persistentContainer.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("was unable to load store \(error!)")
            }
        }
        viewContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        viewContext.automaticallyMergesChangesFromParent = true
        viewContext.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
    }
}
