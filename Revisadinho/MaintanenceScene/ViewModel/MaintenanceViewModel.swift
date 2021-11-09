//
//  MaintenanceViewModel.swift
//  Revisadinho
//
//  Created by Hiago Chagas on 21/09/21.
//  swiftlint:disable line_length identifier_name

import Foundation
import CoreData

class MaintenanceViewModel {
    private let model: Model = Model.shared

    func getMaintenancesByDate(startingDate: Date, endingDate: Date, viewContext: NSManagedObjectContext = DatabaseController.shared.viewContext) -> [Maintenance] {
        var maintenances: [Maintenance] = []
        let maintenancesDAO = model.getMaintenances(byStartDate: startingDate, toDate: endingDate, viewContext: viewContext)
        for maintenance in maintenancesDAO {
            guard let id = maintenance.id else { return []}
            guard let date = maintenance.date else { return []}
            let hodometer = maintenance.hodometer
            let maintenanceItens = maintenance.maintenanceItens?.map { maintenanceItem in
                return MaintenanceItem(rawValue: Int(maintenanceItem))!
            }
            maintenances.append(Maintenance(id: id, hodometer: hodometer, date: date, maintenanceItens: maintenanceItens ?? []))
        }
        return maintenances
    }

    func getMaintenances(byMonth month: Int, andYear year: Int, viewContext: NSManagedObjectContext = DatabaseController.shared.viewContext) -> [Maintenance] {
        var maintenances: [Maintenance] = []
        let maintenancesDAO = model.getMaintenances(byMonth: month, andYear: year, viewContext: viewContext)
        for maintenance in maintenancesDAO {
            guard let id = maintenance.id else { return []}
            guard let date = maintenance.date else { return []}
            let hodometer = maintenance.hodometer
            var maintenanceItens = maintenance.maintenanceItens?.map { maintenanceItem in
                return MaintenanceItem(rawValue: Int(maintenanceItem))!
            }
            maintenanceItens = maintenanceItens?.sorted {
                $0.description.folding(options: .diacriticInsensitive, locale: .current) < $1.description.folding(options: .diacriticInsensitive, locale: .current)
            }
            maintenances.append(Maintenance(id: id, hodometer: hodometer, date: date, maintenanceItens: maintenanceItens ?? []))
        }
        return maintenances
    }
}
