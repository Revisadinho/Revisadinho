//
//  MaintenanceViewModel.swift
//  Revisadinho
//
//  Created by Hiago Chagas on 20/09/21.
//  swiftlint:disable identifier_name line_length

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
}
