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
        self.backgroundColor = .blueBackground
        setUpViewHierarchy()
        setUpTitleLabelConstraints()
        setUpPlusButtonConstraints()
        setUpDateComponentConstraints()
        setUpTableViewConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var dateComponent: DateComponent = {
        let component = DateComponent()
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .blueBackground
        tableView.separatorColor = .gray
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Minhas\nManutenções"
        label.textColor = .grayText
        label.font = label.font.withSize(34)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "plus")?.withTintColor(.purpleAction).withRenderingMode(.alwaysOriginal), for: .normal)
//        button.addTarget(self, action: #selector(delegatesBackButtonActionToController(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setUpViewHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(plusButton)
        self.addSubview(dateComponent)
        self.addSubview(tableView)
    }
    
    func setUpTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 250),
            titleLabel.heightAnchor.constraint(equalToConstant: 82)
        ])
    }
    
    func setUpPlusButtonConstraints() {
        NSLayoutConstraint.activate([
            plusButton.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -5),
            plusButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -28),
            plusButton.widthAnchor.constraint(equalToConstant: 30),
            plusButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setUpDateComponentConstraints() {
        NSLayoutConstraint.activate([
            dateComponent.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 37),
            dateComponent.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dateComponent.widthAnchor.constraint(equalToConstant: 309),
            dateComponent.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func setUpTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: dateComponent.bottomAnchor, constant: 32),
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16 ),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            tableView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
    
}
