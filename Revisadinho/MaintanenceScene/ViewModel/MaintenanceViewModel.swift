//
//  MaintenanceViewModel.swift
//  Revisadinho
//
//  Created by Hiago Chagas on 21/09/21.
//  swiftlint:disable line_length identifier_name
// swiftlint:disable trailing_whitespace line_length

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
            let maintenanceItens = maintenance.maintenanceItens?.map { maintenanceItem in
                return MaintenanceItem(rawValue: Int(maintenanceItem))!
            }
            maintenances.append(Maintenance(id: id, hodometer: hodometer, date: date, maintenanceItens: maintenanceItens ?? []))
        }
        return maintenances
    }
    
    func getAllMaintenances() -> [Maintenance] {
        var maintenances: [Maintenance] = []
        let allMaintenances = model.getMaintenances()
        for maintenance in allMaintenances {
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
    
    func getFutureMaintenances() -> [Maintenance] {
        var futureMaintenances: [Maintenance] = []
        let maintenances = getAllMaintenances()
        let currentDate = Date()
        for maintenance in maintenances where maintenance.date > currentDate {
            futureMaintenances.append(maintenance)
        }
        return futureMaintenances
    }
    
    func getPastMaintenances() -> [Maintenance] {
        var pastMaintenances: [Maintenance] = []
        let maintenances = getAllMaintenances()
        let currentDate = Date()
        for maintenance in maintenances where maintenance.date < currentDate {
            pastMaintenances.append(maintenance)
        }
        return pastMaintenances
    }
    
    func getFutureAndPastMaintenancesFormattedForTableView() -> [[Maintenance]] {
        let pastMaintenances = getPastMaintenances()
        let futureMaintenances = getFutureMaintenances()
        let futureAndPastMaintenances: [[Maintenance]] = [futureMaintenances, pastMaintenances]
        return futureAndPastMaintenances
    }
}
