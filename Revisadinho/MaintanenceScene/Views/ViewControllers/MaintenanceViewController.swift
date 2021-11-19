//
//  ViewController.swift
//  Revisadinho
//
//  Created by Jhennyfer Rodrigues de Oliveira on 13/09/21.
// swiftlint:disable trailing_whitespace line_length

import UIKit
import Foundation

class MaintenanceViewController: UIViewController {
    
    var collectionView: UICollectionView?
    var selectedIndex: IndexPath?
    let maintenanceViewModel = MaintenanceViewModel()
    var placeholderText: UILabel?
    let maintenanceView = MaintenanceView()
    var tableViewHeader: UIView?
    var tableViewSection: UIView?
    var maintenanceRouter: MaintenanceRouter?
    static var tableView: UITableView?
    var collectionViewMaintenanceIndex: IndexPath?
    var sameIndex: Bool = false
    var isExpanded: Bool = false
    
    public var allMaintenances: [[Maintenance]] {
        return maintenanceViewModel.getFutureAndPastMaintenancesFormattedForTableView()
    }
     
    override func loadView() {
        super.loadView()
        maintenanceView.viewController = self
        maintenanceView.delegate = self
        placeholderText = maintenanceView.placeholderText
        MaintenanceViewController.tableView = maintenanceView.tableView
        maintenanceView.tableView.delegate = self
        maintenanceView.tableView.dataSource = self
        self.tableViewHeader = maintenanceView.viewForTableViewHeader
        maintenanceView.setUpViewForTableViewHeaderConstraints()
        view = maintenanceView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MaintenanceViewController.tableView?.tableHeaderView = self.tableViewHeader
        MaintenanceViewController.tableView?.insetsContentViewsToSafeArea = true
        MaintenanceViewController.tableView?.sectionHeaderTopPadding = 0
        MaintenanceViewController.tableView?.reloadData()
       
    }
}

extension MaintenanceViewController: UITableViewDelegate, UITableViewDataSource {
        
    func isTableViewEmpty() -> Bool {
        let totalMaintenances = allMaintenances[0].count + allMaintenances[1].count
        if totalMaintenances < 1 {
            return true
        } else {
            return false
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isTableViewEmpty() {
            placeholderText?.isHidden = false
            MaintenanceViewController.tableView?.bounces = false
            collectionViewMaintenanceIndex?.row = 0
            collectionViewMaintenanceIndex?.section = 0
            return 0
        } else {
            placeholderText?.isHidden = true
            MaintenanceViewController.tableView?.bounces = true
            if section == 0 {
                return allMaintenances[0].count
            } else {
                return allMaintenances[1].count
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let totalMaintenenceItems = allMaintenances[indexPath.section][indexPath.row].maintenanceItens.count
        let numberOfLines = calculateNumberOfLines(numberOfItems: totalMaintenenceItems, numberOfItemsPerLine: 3)
        
        if selectedIndex == indexPath {
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MaintenanceTableViewCell.identifier, for: indexPath) as? MaintenanceTableViewCell
        
        collectionViewMaintenanceIndex = indexPath
        let formatedDate = formatDate(date: allMaintenances[indexPath.section][indexPath.row].date)
             
        guard let cellUnwrapped = cell else {return MaintenanceTableViewCell()}
        
        cellUnwrapped.viewForHidingExcedentLineOfFirstCell.isHidden = true
        if isExpanded && indexPath.row == selectedIndex?.row {
            cellUnwrapped.cardExpansionIndicator.image = UIImage(named: "cardCollapsingIndicator")
        } else {
            cellUnwrapped.cardExpansionIndicator.image = UIImage(named: "cardExpansionIndicator")
        }
         
        cellUnwrapped.hodometerLabel.text = formatHodometerText(hodometer: allMaintenances[indexPath.section][indexPath.row].hodometer)
        collectionView = cellUnwrapped.cardCollectionView
        cellUnwrapped.dateLabel.text = formatedDate
        cellUnwrapped.cardCollectionView.delegate = self
        cellUnwrapped.cardCollectionView.dataSource = self
        cellUnwrapped.cardCollectionView.reloadData()
        cellUnwrapped.animate()
        
        return cellUnwrapped
    }
          
    func formatHodometerText(hodometer: Double) -> String {
        let intHodometer = Int(hodometer)
        let stringHodometer = String(intHodometer)
        return stringHodometer + " " + "km"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if !isTableViewEmpty() {
            if section == 0 {
                return maintenanceView.viewForSections(section: 0)
            } else {
                return maintenanceView.viewForSections(section: 1)
            }
        } else {
            let view = UIView()
            view.backgroundColor = .clear
            return view
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let oldIndex = selectedIndex?.row ?? 0
        let oldSection = selectedIndex?.section ?? 0
        if selectedIndex == indexPath { // user taps more than once in the same cell
            if isExpanded == false {
                sameIndex = false
            } else {
                sameIndex = true
            }
        } else { // user taps in diferent cell
            sameIndex = false
            selectedIndex = indexPath
        }
        // shake animation for cards that have 3 or less items
        guard let cell = (tableView.cellForRow(at: indexPath)) as? MaintenanceTableViewCell else {return}
        if cell.cardCollectionView.numberOfItems(inSection: 0) <= 3 {
            shakeAnimation(cell: cell)
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
    
    func shakeAnimation(cell: MaintenanceTableViewCell) {
        cell.cardCollectionView.transform = CGAffineTransform(translationX: 20, y: 0)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            cell.cardCollectionView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func calculateNumberOfLines(numberOfItems: Int, numberOfItemsPerLine: Int) -> Int {
        if numberOfItems % numberOfItemsPerLine != 0 {
            return (numberOfItems / 3) + 1
        } else {
            return (numberOfItems / 3)
        }
    }
    
    func calculateSizeOfExpandedCell(numberOfLines: Int, itemSize: Int, spaceBetweenItems: Int, insetTop: Int, insetBottom: Int) -> CGFloat {
        let expandedHeight = ((itemSize + spaceBetweenItems)*numberOfLines) + ((insetTop + insetBottom)*2) + 49
        return CGFloat(expandedHeight)
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY/MM/dd"
        let formatedDate = dateFormatter.string(from: date)
        let dateArray = formatedDate.split(separator: "/")
        let year = dateArray[dateArray.count-3]
        guard let month = Int(dateArray[dateArray.count-2]) else { return ""}
        let day = dateArray[dateArray.count-1]
        let monthInWord = DateModel().convertMonthIntToString(monthInt: month)
        let finalFormattedDate: String = day + " " + (monthInWord ?? "") + "," + " " + year
        return finalFormattedDate
    }

}

extension MaintenanceViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let collectionMaintenanceIndex = collectionViewMaintenanceIndex else {return 0}
        if allMaintenances[collectionMaintenanceIndex.section][collectionMaintenanceIndex.row].maintenanceItens.isEmpty {
            return 0
        } else {
            return allMaintenances[collectionMaintenanceIndex.section][collectionMaintenanceIndex.row].maintenanceItens.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MaintenanceCollectionViewCell.identifier, for: indexPath) as? MaintenanceCollectionViewCell
        guard let customCell = cell else {return MaintenanceCollectionViewCell() }
        guard let collectionMaintenanceIndex = collectionViewMaintenanceIndex else {return MaintenanceCollectionViewCell() }
        customCell.setUpItemNameLabelConstraintsForCardVisualization()
        customCell.itemNameLabel.text = allMaintenances[collectionMaintenanceIndex.section][collectionMaintenanceIndex.row].maintenanceItens[indexPath.row].description
        customCell.item.image = UIImage(named: "\(allMaintenances[collectionMaintenanceIndex.section][collectionMaintenanceIndex.row].maintenanceItens[indexPath.row])")
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
