//
//  LightsView.swift
//  Revisadinho
//
//  Created by Leonardo Gomes Fernandes on 18/10/21.
// swiftlint:disable trailing_whitespace line_length

import Foundation
import UIKit

class LightsView: UIView {
    
    var viewControllwe: LightsViewController?
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(LightTableViewCell.self, forCellReuseIdentifier: LightTableViewCell.identifier)
        tableView.isUserInteractionEnabled = true
        return tableView
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.frame = CGRect(x: 0, y: 0, width: 200, height: 70)
        searchBar.showsCancelButton = true
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search Here....."
        searchBar.sizeToFit()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    lazy var viewForTableViewHeader: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 160))
        view.backgroundColor = .blueBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Luzes do Painel"
        label.textColor = .grayText
        label.font = UIFont(name: "Quicksand-Medium", size: 34)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var searchButtonInsideView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        
        let buttonLabel = UILabel()
        buttonLabel.text = "Pesquisar"
        buttonLabel.textColor = .buttonLabelText
        buttonLabel.font = UIFont(name: "Quicksand-Medium", size: 17)
        buttonLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonLabel.isUserInteractionEnabled = false
        
        let imageSymbol = UIImageView(image: UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysOriginal).withTintColor(.buttonLabelText))
        imageSymbol.translatesAutoresizingMaskIntoConstraints = false
        imageSymbol.isUserInteractionEnabled = false
        
        view.addSubview(imageSymbol)
        view.addSubview(buttonLabel)
        
        NSLayoutConstraint.activate([
            
            imageSymbol.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageSymbol.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageSymbol.widthAnchor.constraint(equalToConstant: 20),
            imageSymbol.heightAnchor.constraint(equalToConstant: 20),
            
            buttonLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(origin: .zero, size: CGSize(width: button.widthAnchor.hashValue, height: button.heightAnchor.hashValue))
        button.frame = CGRect(origin: .zero, size: CGSize(width: 158, height: 39))
        button.layer.cornerRadius = 13
        button.backgroundColor = .purpleAction
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        
        let insideView = searchButtonInsideView
        insideView.translatesAutoresizingMaskIntoConstraints = false
        insideView.isUserInteractionEnabled = false
        
        button.addSubview(insideView)
        NSLayoutConstraint.activate([
            insideView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            insideView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            insideView.widthAnchor.constraint(equalTo: button.widthAnchor),
            insideView.heightAnchor.constraint(equalTo: button.heightAnchor)
        ])
        
        button.addTarget(self, action: #selector(toPrint), for: .touchUpInside)
        return button
    }()
    
    lazy var identifyuttonInsideView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        
        let buttonLabel = UILabel()
        buttonLabel.text = "Identificar"
        buttonLabel.textColor = .buttonLabelText
        buttonLabel.font = UIFont(name: "Quicksand-Medium", size: 17)
        buttonLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonLabel.isUserInteractionEnabled = false
        
        let imageSymbol = UIImageView(image: UIImage(systemName: "camera")?.withRenderingMode(.alwaysOriginal).withTintColor(.buttonLabelText))
        imageSymbol.translatesAutoresizingMaskIntoConstraints = false
        imageSymbol.isUserInteractionEnabled = false
        
        view.addSubview(imageSymbol)
        view.addSubview(buttonLabel)
        
        NSLayoutConstraint.activate([
            imageSymbol.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageSymbol.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageSymbol.widthAnchor.constraint(equalToConstant: 25),
            imageSymbol.heightAnchor.constraint(equalToConstant: 22),
            
            buttonLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }()
    
    lazy var identifyButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(origin: .zero, size: CGSize(width: 158, height: 39))
        button.layer.cornerRadius = 13
        button.backgroundColor = .purpleAction
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        
        let insideView = identifyuttonInsideView
        insideView.translatesAutoresizingMaskIntoConstraints = false
        insideView.isUserInteractionEnabled = false
        
        button.addSubview(insideView)
        NSLayoutConstraint.activate([
            insideView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            insideView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            insideView.widthAnchor.constraint(equalTo: button.widthAnchor),
            insideView.heightAnchor.constraint(equalTo: button.heightAnchor)
        ])
        
        button.addTarget(self, action: #selector(toPrint), for: .touchUpInside)
        return button
    }()
    
    @objc func toPrint() {
        print("Button Pressed")
        searchButton.removeFromSuperview()
        identifyButton.removeFromSuperview()
        viewForTableViewHeader.addSubview(searchBar)
        setUpSearchBar()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .blueBackground
        
        setUpTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpTableView() {
        self.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            tableView.heightAnchor.constraint(equalTo: self.heightAnchor),
            tableView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
    func setUpHeaderTableView() {
        NSLayoutConstraint.activate([
            viewForTableViewHeader.widthAnchor.constraint(equalToConstant: viewForTableViewHeader.frame.width),
            viewForTableViewHeader.heightAnchor.constraint(equalToConstant: viewForTableViewHeader.frame.height)
        ])
        
        searchButton.isUserInteractionEnabled = true
        identifyButton.isUserInteractionEnabled = true
        
        viewForTableViewHeader.addSubview(titleLabel)
        viewForTableViewHeader.addSubview(searchButton)
        viewForTableViewHeader.addSubview(identifyButton)
        
        setUpHeaderSearchButton()
        setUpHeaderTitleLabel()
        setUpHeaderIndentiyButton()
    }
    
    func setUpHeaderTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: viewForTableViewHeader.topAnchor, constant: 50),
            titleLabel.leftAnchor.constraint(equalTo: viewForTableViewHeader.leftAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalTo: viewForTableViewHeader.widthAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 45)
        ])
        
    }
    
    func setUpHeaderSearchButton() {
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 28),
            searchButton.leftAnchor.constraint(equalTo: viewForTableViewHeader.leftAnchor, constant: 20),
            searchButton.widthAnchor.constraint(equalToConstant: 158),
            searchButton.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
    
    func setUpHeaderIndentiyButton() {
        NSLayoutConstraint.activate([
            identifyButton.trailingAnchor.constraint(equalTo: viewForTableViewHeader.trailingAnchor, constant: -20),
            identifyButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 28),
            identifyButton.widthAnchor.constraint(equalToConstant: 158),
            identifyButton.heightAnchor.constraint(equalToConstant: 38)
        ])
    }
    
    func setUpSearchBar() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: viewForTableViewHeader.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: viewForTableViewHeader.trailingAnchor, constant: -20)
        ])
    }
}
