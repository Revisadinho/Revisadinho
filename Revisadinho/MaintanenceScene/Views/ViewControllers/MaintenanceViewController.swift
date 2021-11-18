//
//  ViewController.swift
//  Revisadinho
//
//  Created by Jhennyfer Rodrigues de Oliveira on 13/09/21.

import UIKit
import Foundation
import DropDown

class MaintenanceViewController: UIViewController {
    
    var previousSelectedIndex: IndexPath?
    let maintenanceViewModel = MaintenanceViewModel()
    var placeholderText: UILabel?
    let maintenanceView = MaintenanceView()
    var tableViewHeader: UIView?
    var maintenanceRouter: MaintenanceRouter?
    static var tableView: UITableView?
    var collectionViewMaintenanceIndex: IndexPath?
    var sameIndex: Bool = false
    var isExpanded: Bool = false
    var filterCell: FilterCell?
    let dropDown = DropDown()
    
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
        setUpTableViewHeader()
        MaintenanceViewController.tableView?.reloadData()
       
    }
    
    func setUpTableViewHeader() {
        MaintenanceViewController.tableView?.tableHeaderView = self.tableViewHeader
        MaintenanceViewController.tableView?.insetsContentViewsToSafeArea = true
        MaintenanceViewController.tableView?.sectionHeaderTopPadding = 0
    }
}
