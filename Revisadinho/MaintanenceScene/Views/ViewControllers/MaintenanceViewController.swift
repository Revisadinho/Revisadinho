//
//  ViewController.swift
//  Revisadinho
//
//  Created by Jhennyfer Rodrigues de Oliveira on 13/09/21.
// swiftlint:disable trailing_whitespace line_length

import UIKit
import Foundation

class MaintenanceViewController: UIViewController {

    let maintenanceViewModel = MaintenanceViewModel()
    var placeholderText: UILabel?
    let maintenanceView = MaintenanceView()
    var tableViewHeader: UIView?
    var maintenanceRouter: MaintenanceRouter?
    static var tableView: UITableView?
    var collectionViewMaintenanceIndex = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
//        overrideUserInterfaceStyle = .light
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
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MaintenanceTableViewCell.identifier, for: indexPath) as? MaintenanceTableViewCell
        let maintenances = getMaintenances()
        collectionViewMaintenanceIndex = indexPath.row
        let formatedDate = formatDate(date: maintenances[indexPath.row].date)
        cell?.dateLabel.text = formatedDate
        cell?.cardCollectionView.delegate = self
        cell?.cardCollectionView.dataSource = self
        cell?.cardCollectionView.reloadData()
        if indexPath.row == 0 {
                cell?.lineUp.isHidden = true
        }
        
        return cell ?? MaintenanceTableViewCell()
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewForHeader = tableViewHeader
        viewForHeader?.isUserInteractionEnabled = true
        maintenanceView.setUpViewForTableViewHeaderConstraints()
        return viewForHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        260
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let maintenances = getMaintenances()
        let controller = ModalViewController()
        controller.maintenanceItems = maintenances[indexPath.row].maintenanceItens
        controller.maintenanceDate = formatDate(date: maintenances[indexPath.row].date)
        let hodometerInt = Int(maintenances[indexPath.row].hodometer)
        controller.hodometer = String(hodometerInt) + " " + "km"
        self.present(controller, animated: true, completion: nil)
    }
}

extension MaintenanceViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let maintenance = getMaintenances()
        print(collectionViewMaintenanceIndex)
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
