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
    var filterOption = FilterOptions.always
    var textField: UITextField?
    var picker: UIPickerView?
    var choosenYear: Int = Calendar.current.component(.year, from: Date())
    
    public var allMaintenances: [[Maintenance]] {
        return maintenanceViewModel.getFutureAndPastMaintenancesFormattedForTableView()
    }
     
    override func loadView() {
        super.loadView()
        maintenanceView.viewController = self
        maintenanceView.delegate = self
        maintenanceView.textField.delegate = self
        MaintenanceViewController.tableView = maintenanceView.tableView
        maintenanceView.tableView.delegate = self
        maintenanceView.yearPicker.delegate = self
        maintenanceView.yearPicker.dataSource = self
        maintenanceView.tableView.dataSource = self
        maintenanceView.delegateToolbar = self
        picker = maintenanceView.yearPicker
        self.tableViewHeader = maintenanceView.viewForTableViewHeader
        textField = maintenanceView.textField
        maintenanceView.setUpViewForTableViewHeaderConstraints()
        view = maintenanceView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableViewHeader()
        MaintenanceViewController.tableView?.reloadData()
        dropDown.dataSource = ["Todas","Há 6 meses", "Há 1 ano", "Escolher ano"]
        setUpButtonLabelForChoosenItem()
    }
    
    func setUpButtonLabelForChoosenItem() {
        dropDown.selectionAction = { [unowned self] (_: Int, item: String) in
            filterCell?.filterLabel.text = item
            switch item {
            case "Todas":
                filterOption = FilterOptions.always
                filterCell?.filterLabel.text = "Todas"
            case "Há 6 meses":
                filterOption = FilterOptions.sixMonthsAgo
                filterCell?.filterLabel.text = "6 meses"
            case "Há 1 ano":
                filterOption = FilterOptions.yearAgo
                filterCell?.filterLabel.text = "1 ano"
            case "Escolher ano":
                filterOption = FilterOptions.chooseYear
                textField?.becomeFirstResponder()
                let listOfItems = maintenanceViewModel.getListOfYearsForPicker()
                guard let selectedRow = picker?.selectedRow(inComponent: 0) else {return}
                filterCell?.filterLabel.text = String(listOfItems[selectedRow])
            default:
                filterOption = FilterOptions.always
            }
            reloadTableViewScrollToTop(item: 0, section: 1)
        }
    }
    
    func setUpTableViewHeader() {
        MaintenanceViewController.tableView?.tableHeaderView = self.tableViewHeader
        MaintenanceViewController.tableView?.insetsContentViewsToSafeArea = true
        MaintenanceViewController.tableView?.sectionHeaderTopPadding = 0
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

extension MaintenanceViewController: ToolbarActionDelegate {
    func dismissToolbar() {
        textField?.resignFirstResponder()
        filterOption = FilterOptions.always
        filterCell?.filterLabel.text = "Todas"
        MaintenanceViewController.tableView?.reloadData()
        reloadTableViewScrollToTop(item: 0, section: 1)
    }
    
    func saveAndDismissToolbar() {
        textField?.resignFirstResponder()
        MaintenanceViewController.tableView?.reloadData()
        reloadTableViewScrollToTop(item: 0, section: 1)
    }
}

extension MaintenanceViewController: UITextFieldDelegate {

   func textFieldDidBeginEditing(_ textField: UITextField) {
      let listOfItems = maintenanceViewModel.getListOfYearsForPicker()
      let index = 0
      picker?.selectRow(index, inComponent: 0, animated: true)
      choosenYear = listOfItems[index]
      reloadTableViewScrollToTop(item: 0, section: 1)
   }

}
