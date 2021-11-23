//
//  MaintenancePickerDelegate.swift
//  Revisadinho
//
//  Created by Jhennyfer Rodrigues de Oliveira on 19/11/21.
//

import Foundation
import UIKit

extension MaintenanceViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        maintenanceViewModel.getListOfYearsForPicker().count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10.0)
        label.textColor = UIColor.purple
        let list = maintenanceViewModel.getListOfYearsForPicker()
        label.text = String(list[row])
        label.textAlignment = .left
        return NSAttributedString(string: label.text ?? "a")
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let listOfItems = maintenanceViewModel.getListOfYearsForPicker()
        choosenYear = listOfItems[row]
        MaintenanceViewController.tableView?.reloadData()
    }
}
