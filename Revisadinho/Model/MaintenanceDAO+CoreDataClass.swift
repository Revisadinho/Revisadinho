//
//  MaintenanceDAO+CoreDataClass.swift
//  Revisadinho
//
//  Created by Hiago Chagas on 20/09/21.
//
//

import Foundation
import CoreData

@objc(MaintenanceDAO)
public class MaintenanceDAO: NSManagedObject {
    static func fetchAllMaintenances(viewContext: NSManagedObjectContext) -> [MaintenanceDAO] {
        let request: NSFetchRequest<MaintenanceDAO> = MaintenanceDAO.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        guard let maintenances = try? viewContext.fetch(request) else {
            return []
        }
        return maintenances
    }
}
