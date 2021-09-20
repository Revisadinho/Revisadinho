//
//  MaintenanceView.swift
//  Revisadinho
//
//  Created by Jhennyfer Rodrigues de Oliveira on 14/09/21.
// swiftlint:disable trailing_whitespace line_length

import Foundation
import UIKit

protocol PlusButtonDelegate: AnyObject {
    func addNewMaintenance()
}

class MaintenanceView: UIView {
    var viewController: MaintenanceViewController?
    weak var delegate: PlusButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .blueBackground
        setUpViewHierarchy()
        setUpTableViewConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var viewForTableViewHeader: UIView = {
        let view = UIView(frame: CGRect(x: 16, y: 0, width: 350, height: 240))
        view.backgroundColor = .blueBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var dateComponent: DateComponent = {
        let component = DateComponent()
        component.isUserInteractionEnabled = true
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .blueBackground
        tableView.register(MaintenanceTableViewCell.self, forCellReuseIdentifier: MaintenanceTableViewCell.identifier)
        tableView.separatorColor = .gray
        tableView.separatorColor = .blueBackground
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
        
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(delegatesBackButtonActionToController(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func delegatesBackButtonActionToController(sender: UIButton) {
        delegate?.addNewMaintenance()
    }
    
    func setUpViewHierarchy() {
        self.addSubview(tableView)
    }
    
    func setUpViewForTableViewHeaderConstraints() {
        NSLayoutConstraint.activate([
            viewForTableViewHeader.widthAnchor.constraint(equalToConstant: viewForTableViewHeader.frame.width),
            viewForTableViewHeader.heightAnchor.constraint(equalToConstant: viewForTableViewHeader.frame.height)
        ])
        
        viewForTableViewHeader.addSubview(titleLabel)
        viewForTableViewHeader.addSubview(plusButton)
        viewForTableViewHeader.addSubview(dateComponent)
        
        setUpTitleLabelConstraints()
        setUpPlusButtonConstraints()
        setUpDateComponentConstraints()
    }
    
    func setUpTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: viewForTableViewHeader.topAnchor, constant: 50),
            titleLabel.leftAnchor.constraint(equalTo: viewForTableViewHeader.leftAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 250),
            titleLabel.heightAnchor.constraint(equalToConstant: 82)
        ])
    }
    
    func setUpPlusButtonConstraints() {
        NSLayoutConstraint.activate([
            plusButton.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -5),
            plusButton.rightAnchor.constraint(equalTo: viewForTableViewHeader.rightAnchor, constant: -28),
            plusButton.widthAnchor.constraint(equalToConstant: 30),
            plusButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setUpDateComponentConstraints() {
        NSLayoutConstraint.activate([
            dateComponent.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 37),
            dateComponent.centerXAnchor.constraint(equalTo: viewForTableViewHeader.centerXAnchor),
            dateComponent.widthAnchor.constraint(equalToConstant: 309),
            dateComponent.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func setUpTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16 ),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
        
}
