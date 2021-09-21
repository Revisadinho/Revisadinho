//
//  MainRouter.swift
//  Revisadinho
//
//  Created by Leonardo Gomes Fernandes on 21/09/21.
// swiftlint:disable trailing_whitespace

import Foundation
import UIKit

protocol Router {
    func getRootViewController() -> UIViewController
}

class MaintenanceRouter: NSObject, Router {
    
    weak var maintenanceController: MaintenanceViewController?
    let addMaintenanceController: AddMaintenceViewController
    
    var rootViewController: UIViewController {
        return maintenanceController ?? MaintenanceViewController()
    }
    
    init(rootViewController: MaintenanceViewController) {
        maintenanceController = rootViewController
        addMaintenanceController = AddMaintenceViewController()
        
        super.init()
    }
    
    func getRootViewController() -> UIViewController {
        return rootViewController
    }
    
    func displayAddMaintenance() {
        maintenanceController?.show(addMaintenanceController, sender: nil)
    }
    
}
