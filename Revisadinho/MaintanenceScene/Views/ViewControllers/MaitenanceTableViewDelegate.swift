//
//  MaitenanceTableViewDelegate.swift
//  Revisadinho
//
//  Created by Jhennyfer Rodrigues de Oliveira on 14/11/21.
//

import Foundation
import UIKit

extension MaintenanceViewController: UITableViewDelegate, UITableViewDataSource {
     
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isTableViewEmpty() {
            placeholderText?.isHidden = false
            MaintenanceViewController.tableView?.bounces = false
            collectionViewMaintenanceIndex?.row = 0
            collectionViewMaintenanceIndex?.section = 0
        } else {
            placeholderText?.isHidden = true
            MaintenanceViewController.tableView?.bounces = true
        }
        return getAmountOfDataForSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 0 { // filter cell size
            return 100
        } else if allMaintenances[0].isEmpty && indexPath.section == 0 && indexPath.row == 0 { // placeholder cell size for first section
            return 100
        } else if dataOfSelectedItemInFilterIsEmpty() && indexPath.section == 1 && indexPath.row == 1 { // placeholder cell size for second section
            return 100
        } else {
            var totalMaintenanceItems: Int = 0
            if indexPath.section == 1 {
                totalMaintenanceItems = getAmountOfDataForSection(section: 1)
            } else {
                totalMaintenanceItems = allMaintenances[indexPath.section][indexPath.row].maintenanceItens.count
            }
           
            let numberOfLines = calculateNumberOfLines(numberOfItems: totalMaintenanceItems, numberOfItemsPerLine: 3)
            
            if previousSelectedIndex == indexPath {
                if sameIndex {
                    isExpanded = false
                    return CGFloat(MaintenanceTableViewCell.cellHeight)
                }
                if numberOfLines > 1 {
                    isExpanded = true
                    return calculateSizeOfExpandedCell(numberOfLines: numberOfLines, itemSize: 120, spaceBetweenItems: 38, insetTop: 8, insetBottom: 16)
                }
            }
            return CGFloat(MaintenanceTableViewCell.cellHeight)
        }
    
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            if section == 0 {
                return maintenanceView.viewForSections(section: 0)
            } else {
                return maintenanceView.viewForSections(section: 1)
            }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if dataOfSelectedItemInFilterIsEmpty() && indexPath.section == 1 && indexPath.row == 1 {
            return settingUpPlaceholderCellForTableView(tableView: tableView, indexPath: indexPath)
        } else if allMaintenances[0].isEmpty && indexPath.section == 0 && indexPath.row == 0 {
            return settingUpPlaceholderCellForTableView(tableView: tableView, indexPath: indexPath)
        } else if indexPath.section == 1 && indexPath.row == 0 {
            return settingUpFilterCellForTableView(tableView: tableView, indexPath: indexPath)
        } else {
            return settingUpMaintenanceCellForTableView(tableView: tableView, indexPath: indexPath)
        }
    }
    
    func settingUpPlaceholderCellForTableView(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let placeholderCell = tableView.dequeueReusableCell(withIdentifier: PlaceholderCell.identifier, for: indexPath) as? PlaceholderCell
        guard let placeholderCellUnwrapped = placeholderCell else {return PlaceholderCell()}
        if indexPath.section == 0 {
            placeholderCellUnwrapped.placeholderText.text = "Nenhuma manutenção agendada"
        } else {
            placeholderCellUnwrapped.placeholderText.text = "Nenhuma manutenção neste período"
        }
        return placeholderCellUnwrapped
    }
    
    func settingUpFilterCellForTableView(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cellFilter = tableView.dequeueReusableCell(withIdentifier: FilterCell.identifier, for: indexPath) as? FilterCell
                filterCell = cellFilter
                
        dropDown.anchorView = filterCell?.filterView
                     
        guard let filterCellUnwrapped = filterCell else {return FilterCell()}
        filterCellUnwrapped.delegate = self
        if filterOption == .chooseYear {
            let listOfItems = maintenanceViewModel.getListOfYearsForPicker()
            guard let selectedRow = picker?.selectedRow(inComponent: 0) else {return FilterCell()}
            filterCellUnwrapped.filterLabel.text = String(listOfItems[selectedRow])
        }
        return filterCellUnwrapped
    }
    
    func settingUpMaintenanceCellForTableView(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        var formatedDate: String = ""
        let cell = tableView.dequeueReusableCell(withIdentifier: MaintenanceTableViewCell.identifier, for: indexPath) as? MaintenanceTableViewCell
            
        if indexPath.row == 1 && indexPath.section == 1 {
            cell?.viewForHidingExcedentLineOfFirstCell.isHidden = false
        } else {
            cell?.viewForHidingExcedentLineOfFirstCell.isHidden = true
        }
     
        guard let cellUnwrapped = cell else {return MaintenanceTableViewCell()}
            
        if isExpanded && indexPath.row == previousSelectedIndex?.row {
            cellUnwrapped.cardExpansionIndicator.image = UIImage(named: "cardCollapsingIndicator")
        } else {
            cellUnwrapped.cardExpansionIndicator.image = UIImage(named: "cardExpansionIndicator")
        }
        
        if indexPath.section == 1 {
            formatedDate = formatDate(date: getDataForSection(section: 1)[indexPath.row-1].date)
            cellUnwrapped.hodometerLabel.text = formatHodometerText(hodometer: getDataForSection(section: 1)[indexPath.row-1].hodometer)
            collectionViewMaintenanceIndex = IndexPath(row: indexPath.row-1, section: indexPath.section)
        } else {
            formatedDate = formatDate(date:allMaintenances[indexPath.section][indexPath.row].date)
            cellUnwrapped.hodometerLabel.text = formatHodometerText(hodometer: allMaintenances[indexPath.section][indexPath.row].hodometer)
            collectionViewMaintenanceIndex = indexPath
        }

        cellUnwrapped.dateLabel.text = formatedDate
        cellUnwrapped.cardCollectionView.delegate = self
        cellUnwrapped.cardCollectionView.dataSource = self
        cellUnwrapped.cardCollectionView.reloadData()
        cellUnwrapped.animate()
        return cellUnwrapped
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // triggers button action
        if indexPath.section == 1 && indexPath.row == 0 {
            guard let filterCell = filterCell else {return }
            filterCell.delegatesFilterButtonActionToController(sender: filterCell.filterButton)
        }
        let oldIndex = previousSelectedIndex?.row ?? 0
        let oldSection = previousSelectedIndex?.section ?? 0
        if previousSelectedIndex == indexPath { // user taps more than once in the same cell
            if isExpanded == false {
                sameIndex = false
            } else {
                sameIndex = true
            }
        } else { // user taps in diferent cell
            sameIndex = false
            previousSelectedIndex = indexPath
        }
        // shake animation for cards that have 3 or less items
        guard let cell = (tableView.cellForRow(at: indexPath)) as? MaintenanceTableViewCell else {return}
        if cell.cardCollectionView.numberOfItems(inSection: 0) <= 3 {
            shakeAnimation(cell: cell)
            tableView.reloadRows(at: [indexPath, IndexPath(row: oldIndex, section: oldSection)], with: .none)
        } else {
        // expanding and collapsing animation
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.3, animations: {
                tableView.performBatchUpdates {
                    if self.sameIndex == false {
                        tableView.reloadRows(at: [indexPath, IndexPath(row: oldIndex, section: oldSection)], with: .none)
                    } else {
                        tableView.reloadRows(at: [indexPath], with: .none)
                    }
                }
            }, completion: nil)
        
        }
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        
    }
}
