//
//  Maintenance+CoreDataProperties.swift
//  Revisadinho
//
//  Created by Hiago Chagas on 15/09/21.
//
// swiftlint:disable identifier_name

import Foundation
import CoreData

extension Maintenance {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Maintenance> {
        return NSFetchRequest<Maintenance>(entityName: "Maintenance")
    }

    @NSManaged public var date: Date?
    @NSManaged public var hodometer: Double
    @NSManaged public var id: UUID?
    @NSManaged public var maintenances: [Double]?

}

extension Maintenance: Identifiable {

}
