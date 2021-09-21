//
//  AddMaintenceViewController.swift
//  Revisadinho
//
//  Created by Jéssica Araujo on 14/09/21.
//
// swiftlint:disable trailing_whitespace

import UIKit

class AddMaintenceViewController: UIViewController {
    
    lazy var contentView = AddMaintenceView()
    lazy var bottomSheetViewController: BottomSheetViewController = {
        let viewController = BottomSheetViewController()
        viewController.textField = contentView.calendarTextField
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCalendarTextFieldDelegate()
    }
    
    override func loadView() {
        view = contentView
        contentView.saveButton.addTarget(self, action: #selector(printInputs), for: .touchUpInside)
    }
    
    private func showBottomSheetView() {
        bottomSheetViewController.modalPresentationStyle = .overCurrentContext
        present(bottomSheetViewController, animated: true, completion: nil)
    }
    
    @objc
    func printInputs() {
        guard let totalKm = contentView.hodometerTextField.text else {return}
        guard let date = bottomSheetViewController.selectedDate else {return}
        let services = contentView.servicesSelected
        
        print(totalKm)
        print(bottomSheetViewController.getDateString(date))
        print(services)
    }
}

extension AddMaintenceViewController: UITextFieldDelegate {
    
    private func setCalendarTextFieldDelegate() {
        contentView.calendarTextField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == contentView.calendarTextField {
            showBottomSheetView()
        }
    }
}
