//
//  ModalView.swift
//  Revisadinho
//
//  Created by Jhennyfer Rodrigues de Oliveira on 21/09/21.
// swiftlint:disable trailing_whitespace line_length

import Foundation
import UIKit

class ModalView: UIView {
    
    var controller: ModalViewController?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .blueBackground
        setUpViewHierarchy()
        setUpDateLabelViewConstraints()
        setUpCollectionViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "20 Setembro, 2021"
        label.textColor = .grayText
        label.font = UIFont(name: "Quicksand-Bold", size: 21)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 315, height: 130), collectionViewLayout: collectionViewLayout())
        collection.register(MaintenanceCollectionViewCell.self, forCellWithReuseIdentifier: MaintenanceCollectionViewCell.identifier)
        collection.backgroundColor = .blueBackground
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    func setUpViewHierarchy() {
        self.addSubview(dateLabel)
        self.addSubview(collectionView)
    }
    
    func setUpDateLabelViewConstraints() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 32),
            dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: 200),
            dateLabel.heightAnchor.constraint(equalToConstant: 41)
        ])
    }
    
    func setUpCollectionViewConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: dateLabel.topAnchor, constant: 60),
            collectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}

extension ModalView {
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.minimumLineSpacing = 28
        flowLayout.sectionInset = UIEdgeInsets(top: 8, left: 10, bottom: 6, right: 10)
        flowLayout.itemSize = CGSize(width: 110, height: 120)
        return flowLayout
    }
}
