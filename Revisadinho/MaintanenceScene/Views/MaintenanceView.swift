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
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 180))
        view.backgroundColor = .blueBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        let tableView = UITableView(frame: .zero, style: .plain)
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
    
    lazy var plusImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "plus")?.withTintColor(.purpleAction).withRenderingMode(.alwaysOriginal)
        imageView.isUserInteractionEnabled = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton()
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
        plusButton.addSubview(plusImage)
        
        setUpTitleLabelConstraints()
        setUpPlusButtonConstraints()
        setUpPlusImageConstraints()
    }
    
    func viewForSections(section: Int) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 40))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 45))
        imageView.image = UIImage.init(named: "sectionMark")?.withTintColor(.sectionMarkerView)
        let label = UILabel(frame: CGRect(x: 14, y: 0, width: 280, height: 45))
        label.textColor = .sectionMarkLabel
        label.textAlignment = .left
        label.font = UIFont(name: "Quicksand-Bold", size: 19)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        if section == 0 {
            label.text = "Manutenções agendadas"
        } else {
            label.text = "Manutenções anteriores"
        }
        imageView.addSubview(label)
        view.addSubview(imageView)
        view.backgroundColor = .clear
        return view
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
    
    func setUpPlusImageConstraints() {
        NSLayoutConstraint.activate([
            plusImage.bottomAnchor.constraint(equalTo: plusButton.bottomAnchor),
            plusImage.centerXAnchor.constraint(equalTo: plusButton.centerXAnchor),
            plusImage.widthAnchor.constraint(equalToConstant: 30),
            plusImage.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setUpPlusButtonConstraints() {
        NSLayoutConstraint.activate([
            plusButton.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -5),
            plusButton.rightAnchor.constraint(equalTo: viewForTableViewHeader.rightAnchor, constant: -15),
            plusButton.widthAnchor.constraint(equalToConstant: 100),
            plusButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }

    func setUpTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.widthAnchor.constraint(equalTo: self.widthAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
        
}
