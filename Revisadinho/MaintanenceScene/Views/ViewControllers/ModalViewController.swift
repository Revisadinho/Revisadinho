//
//  ModalViewController.swift
//  Revisadinho
//
//  Created by Jhennyfer Rodrigues de Oliveira on 21/09/21.
// swiftlint:disable trailing_whitespace line_length

import Foundation
import UIKit

class ModalViewController: UIViewController {
    var maintenanceDate: String?
    var maintenanceItems: [MaintenanceItem]?
    
    override func loadView() {
        super.loadView()
        let modalView = ModalView()
        modalView.collectionView.delegate = self
        modalView.collectionView.dataSource = self
        modalView.dateLabel.text = maintenanceDate
        modalView.controller = self
        view = modalView
    }
}

extension ModalViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let maintenanceItems = maintenanceItems else {return 0}
        return maintenanceItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MaintenanceCollectionViewCell.identifier, for: indexPath) as? MaintenanceCollectionViewCell
        guard let customCell = cell else {return MaintenanceCollectionViewCell()}
        customCell.setUpItemNameLabelConstraintsForModalVisualization()
        guard let maintenanceItems = maintenanceItems else {return MaintenanceCollectionViewCell()}
        customCell.itemNameLabel.text = maintenanceItems[indexPath.row].description
        customCell.itemNameLabel.font = UIFont(name: "Quicksand-Medium", size: 17)
        customCell.item.image = UIImage(named: "\(String(describing: maintenanceItems[indexPath.row]))")
        return customCell
    }
    
}
