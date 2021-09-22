//
//  AddMaintenceViewController.swift
//  Revisadinho
//
//  Created by Jéssica Araujo on 14/09/21.
//
// swiftlint:disable trailing_whitespace line_length

import UIKit

class AddMaintenceViewController: UIViewController {
    
    lazy var contentView = AddMaintenceView()
    lazy var bottomSheetViewController: BottomSheetViewController = {
        let viewController = BottomSheetViewController()
        viewController.textField = contentView.calendarTextField
        return viewController
    }()
    
    lazy var viewModel = AddMaintenanceViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCalendarTextFieldDelegate()
    }
    
    override func loadView() {
        view = contentView
        contentView.saveButton.addTarget(self, action: #selector(saveInputs), for: .touchUpInside)
    }
    
    private func showBottomSheetView() {
        bottomSheetViewController.modalPresentationStyle = .overCurrentContext
        present(bottomSheetViewController, animated: true, completion: nil)
    }
    
    @objc
    func saveInputs() {
        guard let hodometerText = contentView.hodometerTextField.text else {return}
        guard let date = bottomSheetViewController.selectedDate else {return}
        let services = contentView.servicesSelected
        let totalKm = Double(hodometerText) ?? 0.0
        
        do {
            try viewModel.saveMaintenance(hodometer: totalKm, date: date, maintenanceItens: services)
            clearAddMaintenceView()
            dismiss(animated: true, completion: nil)
            MaintenanceViewController.tableView?.reloadData()
        } catch AddMaintenceError.couldntSaveData {
                showAlert()
        } catch {
            //All other errors
        }
    }
    
    private func showAlert() {
        
        let title = "ERRO"
        let message = "Não foi possível adicionar a manutenção.\nTente novamente!"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let attrsTitle = [NSAttributedString.Key.font: UIFont(name: Fonts.medium, size: 13), NSAttributedString.Key.foregroundColor : UIColor.mainColor]
        let attrsMessage = [NSAttributedString.Key.font: UIFont(name: Fonts.medium, size: 12), NSAttributedString.Key.foregroundColor : UIColor.mainColor]
        
        let attrStringMessage = NSAttributedString(string: alert.message ?? "", attributes: attrsMessage)
        
        let attrStringTitle = NSAttributedString(string: alert.title ?? "", attributes: attrsTitle)
        
        alert.setValue(attrStringTitle, forKey: "attributedTitle")
        alert.setValue(attrStringMessage, forKey: "attributedMessage")
        
        present(alert, animated: true) {
            sleep(3)
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    private func clearAddMaintenceView() {
        guard let date = bottomSheetViewController.selectedDate else {return}
        contentView.servicesSelected.removeAll()
        contentView.servicesCollectionView.deselectAllItems()
        contentView.calendarTextField.text?.removeAll()
        contentView.hodometerTextField.text?.removeAll()
        bottomSheetViewController.contentView.fsCalendar.deselect(date)
    }
}

extension AddMaintenceViewController: UITextFieldDelegate {
    
    private func setCalendarTextFieldDelegate() {
        contentView.calendarTextField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == contentView.calendarTextField {
            showBottomSheetView()
            bottomSheetViewController.setTextFieldCurrentDate()
        }
    }
}
