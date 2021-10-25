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
    var maintenanceRouter: MaintenanceRouter?
    static var tableView: UITableView?
    var collectionViewMaintenanceIndex = 0
    var sameIndex: Bool = false
    var isExpanded: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MaintenanceViewController.tableView?.reloadData()
    }
    
    override func loadView() {
        super.loadView()
        maintenanceView.viewController = self
        maintenanceView.delegate = self
        placeholderText = maintenanceView.placeholderText
        MaintenanceViewController.tableView = maintenanceView.tableView
        maintenanceView.tableView.delegate = self
        maintenanceView.tableView.dataSource = self
        maintenanceView.dateComponent.delegateReloadTableView = self
        self.tableViewHeader = maintenanceView.viewForTableViewHeader
        view = maintenanceView
    }
}

extension MaintenanceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let maintenances = getMaintenances()
        if maintenances.count<1 {
            placeholderText?.isHidden = false
            MaintenanceViewController.tableView?.bounces = false
            collectionViewMaintenanceIndex = 0
            return 0
        } else {
            placeholderText?.isHidden = true
            MaintenanceViewController.tableView?.bounces = true
            return maintenances.count
        }        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let maintenences = getMaintenances()
        let totalMaintenenceItems = maintenences[indexPath.row].maintenanceItens.count
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
   
        let maintenances = getMaintenances()
        collectionViewMaintenanceIndex = indexPath.row
        let formatedDate = formatDate(date: maintenances[indexPath.row].date)
        
        guard let cellUnwrapped = cell else {return MaintenanceTableViewCell()}
        
        if indexPath.row == 0 {
            cellUnwrapped.viewForHidingExcedentLineOfFirstCell.isHidden = false
        } else {
            cellUnwrapped.viewForHidingExcedentLineOfFirstCell.isHidden = true
        }
        
        collectionView = cellUnwrapped.cardCollectionView
        cellUnwrapped.dateLabel.text = formatedDate
        cellUnwrapped.cardCollectionView.delegate = self
        cellUnwrapped.cardCollectionView.dataSource = self
        cellUnwrapped.cardCollectionView.reloadData()
        cellUnwrapped.animate()
        
        return cellUnwrapped
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewForHeader = tableViewHeader
        viewForHeader?.isUserInteractionEnabled = true
        maintenanceView.setUpViewForTableViewHeaderConstraints()
        return viewForHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let oldIndex = selectedIndex?.row ?? 0
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

        // reload table view rows
        tableView.beginUpdates()
        if sameIndex == false {
            tableView.reloadRows(at: [indexPath, IndexPath(row: oldIndex, section: 0)], with: .none)
        } else {
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        tableView.endUpdates()
        tableView.scrollToRow(at: indexPath, at: .none, animated: true)
        
        // shake animation for cards that have 3 or less items
        guard let cell = (tableView.cellForRow(at: indexPath)) as? MaintenanceTableViewCell else {return}
        if cell.cardCollectionView.numberOfItems(inSection: 0) <= 3 {
            shakeAnimation(cell: cell)
        }
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
        let expandedHeight = ((itemSize + spaceBetweenItems)*numberOfLines) + ((insetTop + insetBottom)*2)
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
    
    func getMaintenances() -> [Maintenance] {
        let lastMonthState = DateComponentController.getLastStateMonth()
        let lastYearState = DateComponentController.getLastStateYear()
        let maintenances = maintenanceViewModel.getMaintenances(byMonth: lastMonthState, andYear: lastYearState)
        return maintenances
    }
}

extension MaintenanceViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let maintenance = getMaintenances()
        if maintenance.count == 0 {
            return 0
        } else {
            return maintenance[collectionViewMaintenanceIndex].maintenanceItens.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MaintenanceCollectionViewCell.identifier, for: indexPath) as? MaintenanceCollectionViewCell
        let maintenances = getMaintenances()
        guard let customCell = cell else {return MaintenanceCollectionViewCell() }
        customCell.setUpItemNameLabelConstraintsForCardVisualization()
        customCell.itemNameLabel.text = maintenances[collectionViewMaintenanceIndex].maintenanceItens[indexPath.row].description
        customCell.item.image = UIImage(named: "\(maintenances[collectionViewMaintenanceIndex].maintenanceItens[indexPath.row])")
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
