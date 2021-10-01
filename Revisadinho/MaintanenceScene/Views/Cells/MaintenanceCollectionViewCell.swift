//
//  MaintenanceCollectionViewCell.swift
//  Revisadinho
//
//  Created by Jhennyfer Rodrigues de Oliveira on 16/09/21.
// swiftlint:disable trailing_whitespace

import Foundation
import UIKit

class MaintenanceCollectionViewCell: UICollectionViewCell {
    
    static var identifier = "MaintenanceCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpViewHierarchy()
        setUpItemSquareConstraints()
        setUpItemConstraints()
//        setUpItemNameLabelConstraints()

    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        itemSquare.layer.borderColor = UIColor.borderServiceItem.cgColor
    }
    
    func setUpViewHierarchy() {
        self.addSubview(itemSquare)
        itemSquare.addSubview(item)
//        self.addSubview(itemNameLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var itemSquare: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 55))
        view.backgroundColor = .monthCardBackground
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.borderServiceItem.cgColor
        view.layer.cornerRadius = 7
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var item: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Correia Dentada"
        label.textColor = .grayText
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = label.font.withSize(14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
         
    func setUpItemSquareConstraints() {
        NSLayoutConstraint.activate([
            itemSquare.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            itemSquare.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            itemSquare.widthAnchor.constraint(equalToConstant: itemSquare.frame.width),
            itemSquare.heightAnchor.constraint(equalToConstant: itemSquare.frame.height)
        ])
    }
    
    func setUpItemConstraints() {
        NSLayoutConstraint.activate([
            item.centerXAnchor.constraint(equalTo: itemSquare.centerXAnchor),
            item.centerYAnchor.constraint(equalTo: itemSquare.centerYAnchor),
            item.widthAnchor.constraint(equalToConstant: 35),
            item.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    func setUpItemNameLabelConstraintsForCardVisualization() {
        self.addSubview(itemNameLabel)
        NSLayoutConstraint.activate([
            itemNameLabel.centerXAnchor.constraint(equalTo: itemSquare.centerXAnchor),
            itemNameLabel.topAnchor.constraint(equalTo: itemSquare.bottomAnchor, constant: 6),
            itemNameLabel.widthAnchor.constraint(equalToConstant: 100),
            itemNameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setUpItemNameLabelConstraintsForModalVisualization() {
        self.addSubview(itemNameLabel)
        NSLayoutConstraint.activate([
            itemNameLabel.centerXAnchor.constraint(equalTo: itemSquare.centerXAnchor),
            itemNameLabel.topAnchor.constraint(equalTo: itemSquare.bottomAnchor, constant: 6),
            itemNameLabel.widthAnchor.constraint(equalToConstant: 110),
            itemNameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension MaintenanceCollectionViewCell {
    
    static func collectionViewLayout() -> UICollectionViewLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 4
        flowLayout.minimumLineSpacing = 38
        flowLayout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 6, right: 8)
        flowLayout.itemSize = CGSize(width: 95, height: 120)
        return flowLayout
    }
}
