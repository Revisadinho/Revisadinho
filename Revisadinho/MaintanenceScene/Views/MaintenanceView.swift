//
//  MaintenanceView.swift
//  Revisadinho
//
//  Created by Jhennyfer Rodrigues de Oliveira on 14/09/21.
// swiftlint:disable trailing_whitespace line_length

import Foundation
import UIKit

class MaintenanceView: UIView {
    var viewController: MaintenanceViewController?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        setUpViewHierarchy()
        setUpDateComponentConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var dateComponent: DateComponent = {
        let component = DateComponent()
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    }()
    
    func setUpViewHierarchy() {
        self.addSubview(dateComponent)
    }
    
    func setUpDateComponentConstraints() {
        NSLayoutConstraint.activate([
            dateComponent.topAnchor.constraint(equalTo: self.topAnchor, constant: 32),
            dateComponent.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dateComponent.widthAnchor.constraint(equalToConstant: 309),
            dateComponent.heightAnchor.constraint(equalToConstant: 55)         
        ])
    }
    
}
