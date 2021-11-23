//
//  MaintenanceCollectionViewDelegate.swift
//  Revisadinho
//
//  Created by Jhennyfer Rodrigues de Oliveira on 14/11/21.
//

import Foundation
import UIKit

extension MaintenanceViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let collectionMaintenanceIndex = collectionViewMaintenanceIndex else {return 0}
        
        if collectionMaintenanceIndex.section == 1 {
            if getDataForSection(section: 1)[collectionMaintenanceIndex.row].maintenanceItens.isEmpty {
                return 0
            } else {
                return getDataForSection(section: 1)[collectionMaintenanceIndex.row].maintenanceItens.count
            }
        } else {
            if allMaintenances[collectionMaintenanceIndex.section][collectionMaintenanceIndex.row].maintenanceItens.isEmpty {
                return 0
            } else {
                return allMaintenances[collectionMaintenanceIndex.section][collectionMaintenanceIndex.row].maintenanceItens.count
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MaintenanceCollectionViewCell.identifier, for: indexPath) as? MaintenanceCollectionViewCell
        guard let customCell = cell else {return MaintenanceCollectionViewCell() }
        guard let collectionMaintenanceIndex = collectionViewMaintenanceIndex else {return MaintenanceCollectionViewCell() }
        customCell.setUpItemNameLabelConstraintsForCardVisualization()
    
        if collectionViewMaintenanceIndex?.section == 1 {
            customCell.itemNameLabel.text = getDataForSection(section: 1)[collectionMaintenanceIndex.row].maintenanceItens[indexPath.row].description
            customCell.item.image =      UIImage(named: "\(getDataForSection(section: 1)[collectionMaintenanceIndex.row].maintenanceItens[indexPath.row])")
        } else {
            customCell.itemNameLabel.text = allMaintenances[collectionMaintenanceIndex.section][collectionMaintenanceIndex.row].maintenanceItens[indexPath.row].description
            customCell.item.image = UIImage(named: "\(allMaintenances[collectionMaintenanceIndex.section][collectionMaintenanceIndex.row].maintenanceItens[indexPath.row])")
        }
        
        customCell.itemNameLabel.font = UIFont(name: "Quicksand-Medium", size: 15)

        return cell ?? MaintenanceCollectionViewCell()
    }
}
