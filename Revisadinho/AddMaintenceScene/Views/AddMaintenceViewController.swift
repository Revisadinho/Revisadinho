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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCalendarTextFieldDelegate()
    }
    
    override func loadView() {
        view = contentView
    }
    
    private func showBottomSheetView() {
        bottomSheetViewController.modalPresentationStyle = .overCurrentContext
        present(bottomSheetViewController, animated: true, completion: nil)
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
