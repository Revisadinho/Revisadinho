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
    let maintenanceView = MaintenanceView()
    var tableViewHeader: UIView?
    var maintenanceRouter: MaintenanceRouter?
    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func loadView() {
        super.loadView()
        maintenanceView.viewController = self
        maintenanceView.delegate = self
        tableView = maintenanceView.tableView
        maintenanceView.tableView.delegate = self
        maintenanceView.tableView.dataSource = self
        maintenanceView.dateComponent.delegateReloadTableView = self
        self.tableViewHeader = maintenanceView.viewForTableViewHeader        
        view = maintenanceView
    }

}

extension MaintenanceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let lastMonthState = DateComponentController.getLastStateMonth()
        let lastYearState = DateComponentController.getLastStateYear()
        let maintenances = maintenanceViewModel.getMaintenances(byMonth: lastMonthState, andYear: lastYearState)
        return maintenances.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MaintenanceTableViewCell.identifier, for: indexPath) as? MaintenanceTableViewCell
        let lastMonthState = DateComponentController.getLastStateMonth()
        let lastYearState = DateComponentController.getLastStateYear()
        let maintenances = maintenanceViewModel.getMaintenances(byMonth: lastMonthState, andYear: lastYearState)
        cell?.dateLabel.text = maintenances[indexPath.row].date.description
        cell?.cardCollectionView.delegate = self
        cell?.cardCollectionView.dataSource = self
        
        if indexPath.row == 0 {
            cell?.lineUp.isHidden = true
        }
        
//        if indexPath.row == indexPath.row. {
//            cell?.lineUp.isHidden = true
//        }
        return cell ?? MaintenanceTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewForHeader = tableViewHeader
        viewForHeader?.isUserInteractionEnabled = true
        maintenanceView.setUpViewForTableViewHeaderConstraints()
        return viewForHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        240
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = ModalViewController()
        self.present(controller, animated: true, completion: nil)
    }
}

extension MaintenanceViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MaintenanceCollectionViewCell.identifier, for: indexPath) as? MaintenanceCollectionViewCell
        
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
        print("ieii")
        tableView?.reloadData()
    }
    
    func reloadTableViewForNextMonth() {
        tableView?.reloadData()
    }
}
