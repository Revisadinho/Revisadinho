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
        setUpItemNameLabelConstraints()

    }
    
    func setUpViewHierarchy() {
        self.addSubview(itemSquare)
        itemSquare.addSubview(item)
        self.addSubview(itemNameLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var itemSquare: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.843, green: 0.859, blue: 0.976, alpha: 1).cgColor
        view.layer.cornerRadius = 7
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var item: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
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
//            itemSquare.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            itemSquare.widthAnchor.constraint(equalToConstant: itemSquare.frame.width),
            itemSquare.heightAnchor.constraint(equalToConstant: itemSquare.frame.height)
        ])
    }
    
    func setUpItemConstraints() {
        NSLayoutConstraint.activate([
            item.centerXAnchor.constraint(equalTo: itemSquare.centerXAnchor),
            item.centerYAnchor.constraint(equalTo: itemSquare.centerYAnchor),
            item.widthAnchor.constraint(equalToConstant: 30),
            item.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setUpItemNameLabelConstraints() {
        NSLayoutConstraint.activate([
            itemNameLabel.centerXAnchor.constraint(equalTo: itemSquare.centerXAnchor),
            itemNameLabel.topAnchor.constraint(equalTo: itemSquare.bottomAnchor, constant: 6),
            itemNameLabel.widthAnchor.constraint(equalToConstant: 70),
            itemNameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension MaintenanceCollectionViewCell {
    
    static func collectionViewLayout() -> UICollectionViewLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 38
        flowLayout.sectionInset = UIEdgeInsets(top: 8, left: 5, bottom: 6, right: 5)
        flowLayout.itemSize = CGSize(width: 70, height: 120)
        return flowLayout
    }
}
