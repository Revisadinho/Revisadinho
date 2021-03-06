//
//  BottomSheetViewController.swift
//  Revisadinho
//
//  Created by Jéssica Araujo on 16/09/21.
//
// swiftlint:disable trailing_whitespace

import UIKit
import FSCalendar

class BottomSheetViewController: UIViewController {
    let contentView = BottomSheetView()
    var textField: UITextField?
    var selectedDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        overrideUserInterfaceStyle = .light
        setTextFieldCurrentDate()
        hideBottomSheetView()
        setFSCalendarDelegate()
        setSelectButtonTarget()
    }
    
    override func loadView() {
        view = contentView
        setTextFieldCurrentDate()
    }
    
    func setSelectButtonTarget() {
        contentView.selectButton.addTarget(self, action: #selector(dismissBottomSheetView), for: .touchUpInside)
    }
    
    func hideBottomSheetView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissBottomSheetView))
        tapGesture.cancelsTouchesInView = false
        contentView.blurView.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func dismissBottomSheetView() {
        dismiss(animated: true, completion: nil)
        if textField != nil {
            textField?.endEditing(true)
        }
        
    }
}

extension BottomSheetViewController: FSCalendarDelegate {
    private func setFSCalendarDelegate() {
        contentView.fsCalendar.delegate = self
    }
    
    public func setTextFieldCurrentDate() {
        if textField != nil {
            textField?.text = getDateString(contentView.fsCalendar.today ?? Date())
            selectedDate = contentView.fsCalendar.today
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if textField != nil {
            textField?.text = getDateString(date)
        }
        selectedDate = date
    }
    
    public func getDateString(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = "dd MMMM, yyyy"
        return dateFormatter.string(from: date)
    }
}
