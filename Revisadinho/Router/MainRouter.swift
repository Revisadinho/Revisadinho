//
//  MainRouter.swift
//  Revisadinho
//
//  Created by Leonardo Gomes Fernandes on 21/09/21.
// swiftlint:disable trailing_whitespace line_length

import Foundation
import UIKit

class MainRouter: NSObject, UITabBarControllerDelegate {
    
    let maintenanceRouter: MaintenanceRouter
    let maintenanceViewController = MaintenanceViewController()
    
    let lightsRouter: LightsRouter
    let lightsViewController = LightsViewController()
    
    let tabBarController = TabBarController()
    
    override init() {
        maintenanceRouter = MaintenanceRouter(rootViewController: maintenanceViewController)
        maintenanceViewController.maintenanceRouter = maintenanceRouter
        
        lightsRouter = LightsRouter(rootViewController: lightsViewController)
        lightsViewController.lightsRouter = lightsRouter
        
        super.init()
        tabBarController.delegate = self
        setupTabBar()
    }
    
    func setupTabBar() {
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.green], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.purpleTabBarItem], for: .selected)
        
        setupVc(viewController: maintenanceRouter.rootViewController, image: UIImage(named: "tool")!, title: "Manutenção")
        setupVc(viewController: lightsRouter.rootViewController, image: UIImage(named: "light")!, title: "Luzes do Painel")
        
        tabBarController.viewControllers = [maintenanceRouter.rootViewController, lightsRouter.rootViewController]
        tabBarController.tabBar.isHidden = false
    }
    
    func setupVc(viewController: UIViewController, image: UIImage, title: String) {
        viewController.tabBarController?.tabBar.tintColor = .blueTabBar
        viewController.tabBarItem.image = image
        viewController.tabBarItem.selectedImage = image.withTintColor(.purpleTabBarItem)
        viewController.tabBarItem.image?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.selectedImage?.withRenderingMode(.alwaysOriginal)
        viewController.title = title
        
    }
    
    func getTabBarController() -> TabBarController {
        return tabBarController
    }
    
    func getMaintenanceViewController() -> MaintenanceViewController {
        return maintenanceViewController
    }
    
    func getLightsViewController() -> LightsViewController {
        return lightsViewController
    }
}
