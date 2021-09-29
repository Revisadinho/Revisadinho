//
//  Maintenance.swift
//  Revisadinho
//
//  Created by Hiago Chagas on 20/09/21.
//  swiftlint:disable identifier_name

import Foundation

struct Maintenance {
    var id: UUID
    var hodometer: Double
    var date: Date
    var maintenanceItens: [MaintenanceItem]

    init(id: UUID, hodometer: Double, date: Date, maintenanceItens: [MaintenanceItem]) {
        self.id = id
        self.hodometer = hodometer
        self.date = date
        self.maintenanceItens = maintenanceItens
    }
}
