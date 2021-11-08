//
//  TabBarController.swift
//  Revisadinho
//
//  Created by Leonardo Gomes Fernandes on 13/10/21.
//
// swiftlint:disable trailing_whitespace line_length

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    static var tableViewHeight: CGFloat?

    let appearanceTabBar: UITabBarAppearance = {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .tabBarColor
        return appearance
    }()
    
    let appearenceItemTabBar: UITabBarItemAppearance = {
        let appearance = UITabBarItemAppearance()
        appearance.normal.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Quicksand-Medium", size: 10)!]
        appearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.purpleTabBarItem,
                                                   NSAttributedString.Key.font: UIFont(name: "Quicksand-Medium", size: 10)!]
        
        return appearance
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TabBarController.tableViewHeight = self.tabBar.frame.height
        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = true
        self.tabBar.layer.cornerRadius = 20
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        tabBar.tintColor = .purpleTabBarItem
        appearanceTabBar.stackedLayoutAppearance = appearenceItemTabBar
        tabBar.standardAppearance = appearanceTabBar
        tabBar.scrollEdgeAppearance = appearanceTabBar
    }

}
