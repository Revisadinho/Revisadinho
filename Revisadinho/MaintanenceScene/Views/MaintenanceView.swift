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
        setUpPlaceholderConstraints()
        setUpTableViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var viewForTableViewHeader: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 250))
        view.backgroundColor = .blueBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var dateComponent: DateComponent = {
        let component = DateComponent.dateComponent
        component.isUserInteractionEnabled = true
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    }()
    
    lazy var placeholderText: UILabel = {
        let label = UILabel()
        label.text = "Nenhuma manutenção cadastrada para este mês"
        label.textColor = .purpleDayNameCalendar
        label.isHidden = true
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "Quicksand-Bold", size: 19)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.register(MaintenanceTableViewCell.self, forCellReuseIdentifier: MaintenanceTableViewCell.identifier)
        tableView.separatorColor = .gray
        tableView.separatorColor = .blueBackground
        tableView.backgroundColor = .blueBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Minhas\nManutenções"
        label.textColor = .grayText
        label.font = UIFont(name: "Quicksand-Medium", size: 34)
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
        self.addSubview(placeholderText)
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
    
    func setUpPlaceholderConstraints() {
        NSLayoutConstraint.activate([
            placeholderText.topAnchor.constraint(equalTo: self.topAnchor, constant: 320),
            placeholderText.widthAnchor.constraint(equalToConstant: 300),
            placeholderText.heightAnchor.constraint(equalToConstant: 100),
            placeholderText.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func setUpTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: viewForTableViewHeader.topAnchor, constant: 50),
            titleLabel.leftAnchor.constraint(equalTo: viewForTableViewHeader.leftAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 250),
            titleLabel.heightAnchor.constraint(equalToConstant: 85)
        ])
    }
    
    func setUpPlusButtonConstraints() {
        NSLayoutConstraint.activate([
            plusButton.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -5),
            plusButton.rightAnchor.constraint(equalTo: viewForTableViewHeader.rightAnchor, constant: -15),
            plusButton.widthAnchor.constraint(equalToConstant: 30),
            plusButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setUpDateComponentConstraints() {
        NSLayoutConstraint.activate([
            dateComponent.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 37),
            dateComponent.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            dateComponent.rightAnchor.constraint(equalTo: plusButton.leftAnchor),
            dateComponent.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    func setUpTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.widthAnchor.constraint(equalTo: self.widthAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -(TabBarController.tableViewHeight ?? 0))
        ])
    }
        
}
