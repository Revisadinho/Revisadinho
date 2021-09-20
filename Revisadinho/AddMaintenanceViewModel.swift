//
//  AddMaintenanceViewModel.swift
//  Revisadinho
//
//  Created by Hiago Chagas on 20/09/21.
//  swiftlint:disable line_length identifier_name

import Foundation
import CoreData

class AddMaintenanceViewModel {
    private let model: Model = Model.shared

    func saveMaintenance(id: UUID = UUID(), hodometer: Double, date: Date, maintenanceItens: [MaintenanceItem], viewContext: NSManagedObjectContext = DatabaseController.shared.viewContext) -> Bool {
        let items = maintenanceItens.map { item in
            return Double(item.rawValue)
        }
        let result = model.createMaintenance(uuid: id, date: date, hodometer: hodometer, maintenanceItens: items, viewContext: viewContext)
        if result != nil {
            return true
        }
        return false
    }
}
