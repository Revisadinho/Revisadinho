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
        
        if section == 1 {
            if allMaintenances[collectionMaintenanceIndex.section][collectionMaintenanceIndex.row-1].maintenanceItens.isEmpty {
                return 0
            } else {
                return allMaintenances[collectionMaintenanceIndex.section][collectionMaintenanceIndex.row-1].maintenanceItens.count
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
    
        if indexPath.section == 1 {
            customCell.itemNameLabel.text = allMaintenances[collectionMaintenanceIndex.section][collectionMaintenanceIndex.row-1].maintenanceItens[indexPath.row-1].description
            customCell.item.image = UIImage(named: "\(allMaintenances[collectionMaintenanceIndex.section][collectionMaintenanceIndex.row-1].maintenanceItens[indexPath.row-1])")
        } else {
            customCell.itemNameLabel.text = allMaintenances[collectionMaintenanceIndex.section][collectionMaintenanceIndex.row].maintenanceItens[indexPath.row].description
            customCell.item.image = UIImage(named: "\(allMaintenances[collectionMaintenanceIndex.section][collectionMaintenanceIndex.row].maintenanceItens[indexPath.row])")
        }
        
        customCell.itemNameLabel.font = UIFont(name: "Quicksand-Medium", size: 15)

        return cell ?? MaintenanceCollectionViewCell()
    }
}

extension MaintenanceViewController: PlusButtonDelegate {
    func addNewMaintenance() {
        maintenanceRouter?.displayAddMaintenance()
    }
}

extension MaintenanceViewController: ReloadTableViewDelegate {
    func reloadTableViewForPreviousMonth() {
        MaintenanceViewController.tableView?.reloadData()
    }
    
    func reloadTableViewForNextMonth() {
        MaintenanceViewController.tableView?.reloadData()
    }
}

extension MaintenanceViewController: FilterButtonActionDelegate {
    func showDropDown(sender: Any) {
        dropDown.show()

    }
}
