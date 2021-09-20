//
//  Maintenance+CoreDataClass.swift
//  Revisadinho
//
//  Created by Hiago Chagas on 20/09/21.
//
//

import Foundation
import CoreData

@objc(Maintenance)
public class Maintenance: NSManagedObject {
    static func fetchAllMaintenances(viewContext: NSManagedObjectContext) -> [Maintenance] {
        let request: NSFetchRequest<Maintenance> = Maintenance.fetchRequest()
//        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        guard let maintenances = try? viewContext.fetch(request) else {
            return []
        }
        return maintenances
    }
}
