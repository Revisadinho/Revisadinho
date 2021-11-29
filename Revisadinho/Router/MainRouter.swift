//
//  MainRouter.swift
//  Revisadinho
//
//  Created by Leonardo Gomes Fernandes on 21/09/21.

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
        tabBarController.appearenceItemTabBar.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.purpleNoSelectedItemTabBar]
        tabBarController.appearenceItemTabBar.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.purpleTabBarItem]
        setupVc(viewController: maintenanceRouter.rootViewController, imageSelected: UIImage(named: "tool")!, imageUnselected: UIImage(named: "toolUnselected")!, title: "Manutenção")
        setupVc(viewController: lightsRouter.rootViewController, imageSelected: UIImage(named: "light")!, imageUnselected: UIImage(named: "lightUnselected")!, title: "Luzes do Painel")
        
        tabBarController.viewControllers = [maintenanceRouter.rootViewController, lightsRouter.rootViewController]
        tabBarController.tabBar.isHidden = false
    }
    
    func setupVc(viewController: UIViewController, imageSelected: UIImage, imageUnselected: UIImage, title: String) {
        viewController.tabBarController?.tabBar.tintColor = .blueTabBar
        viewController.tabBarItem.image = imageUnselected.withTintColor(.purpleNoSelectedItemTabBar).withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.selectedImage = imageSelected.withTintColor(.purpleTabBarItem).withRenderingMode(.alwaysOriginal)
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
