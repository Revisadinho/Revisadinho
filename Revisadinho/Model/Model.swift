//
//  Model.swift
//  Revisadinho
//
//  Created by Hiago Chagas on 14/09/21.
//  swiftlint:disable line_length

import Foundation
import CoreData

public class Model {

    static let shared = Model()
    private let database: DatabaseController

    var persistentContainer: NSPersistentContainer {
        return database.persistentContainer
    }
    
    var viewContext: NSManagedObjectContext {
        return database.persistentContainer.viewContext
    }

    private init() {
        database = DatabaseController()
    }

    private func getMaintenances() -> [Maintenance] {
        let maintenances = Maintenance.fetchAllMaintenances(viewContext: viewContext)
        return maintenances
    }

    public func getMaintenances(byStartDate startDate: Date, toDate finishingDate: Date) -> [Maintenance] {
        let maintenances = getMaintenances()
        let filteredMaintenances = maintenances.filter {
            $0.date ?? Date() > startDate && $0.date ?? Date() < finishingDate
        }
        return filteredMaintenances
    }

    public func getMaintenances(byUUID uuid: UUID) -> Maintenance {
        let maintenances = getMaintenances()
        let filteredMaintenance = maintenances.first { $0.id == uuid }
        return filteredMaintenance!
    }

    public func createMaintenance(uuid: UUID = UUID(), date: Date, hodometer: Double, maintenanceItens: [Double]) {
        if let maintenance = NSEntityDescription.insertNewObject(forEntityName: "Maintenance", into: viewContext) as? Maintenance {
            maintenance.id = uuid
            maintenance.date = date
            maintenance.hodometer = hodometer
            maintenance.maintenances = maintenanceItens
            database.saveContext()
        }
    }

    public func deleteMaintenance(byUUID uuid: UUID) {
        let maintenance = getMaintenances(byUUID: uuid)
        viewContext.delete(maintenance)
        database.saveContext()
    }

    public func updateMaintenance(byUUID uuid: UUID, date: Date? = nil, hodometer: Double? = nil, maintenanceItens: [Double]? = nil) {
        let maintenance = getMaintenances(byUUID: uuid)
        if let date = date {
            maintenance.date = date
        }
        if let hodometer = hodometer {
            maintenance.hodometer = hodometer
        }
        if let maintenanceItens = maintenanceItens {
            maintenance.maintenances = maintenanceItens
        }
        database.saveContext()
    }
}
