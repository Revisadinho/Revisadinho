//
//  LightsRouter.swift
//  Revisadinho
//
//  Created by Leonardo Gomes Fernandes on 18/10/21.
//
// swiftlint:disable trailing_whitespace

import Foundation
import UIKit

class LightsRouter: NSObject, Router {
    
    weak var lightsController: LightsViewController?
    
    var rootViewController: UIViewController {
        return lightsController ?? LightsViewController()
    }
    
    init(rootViewController: LightsViewController) {
        lightsController = rootViewController
        
        super.init()
    }
    
    func getRootViewController() -> UIViewController {
        return rootViewController
    }
    
}
