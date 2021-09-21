//
//  MainRouter.swift
//  Revisadinho
//
//  Created by Leonardo Gomes Fernandes on 21/09/21.
// swiftlint:disable trailing_whitespace

import Foundation
import UIKit

class MainRouter: NSObject {
    
    let maintenanceRouter: MaintenanceRouter
    let maintenanceViewController = MaintenanceViewController()
    
    override init() {
        maintenanceRouter = MaintenanceRouter(rootViewController: maintenanceViewController)
        maintenanceViewController.maintenanceRouter = maintenanceRouter
    }
    
    func getMaintenanceViewController() -> MaintenanceViewController {
        return maintenanceViewController
    }
}
