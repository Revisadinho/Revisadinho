//
//  MaintenanceDAO+CoreDataProperties.swift
//  Revisadinho
//
//  Created by Hiago Chagas on 20/09/21.
//
// swiftlint:disable identifier_name

import Foundation
import CoreData

extension MaintenanceDAO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MaintenanceDAO> {
        return NSFetchRequest<MaintenanceDAO>(entityName: "MaintenanceDAO")
    }

    @NSManaged public var date: Date?
    @NSManaged public var hodometer: Double
    @NSManaged public var id: UUID?
    @NSManaged public var maintenanceItens: [Double]?

}

extension MaintenanceDAO: Identifiable {

}
