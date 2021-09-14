//
//  AddMaintenceView.swift
//  Revisadinho
//
//  Created by Jéssica Araujo on 14/09/21.
//
// swiftlint:disable trailing_whitespace line_length

import UIKit

class AddMaintenceView: UIView {
    
    private let titleLabel = CustomLabel()
    private let calendarLabel = CustomLabel()
    private let hodometerLabel = CustomLabel()
    
    private let calendarTextField = CustomTextField()
    private let hodometerTextField = CustomTextField()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAddMaintenceView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupAddMaintenceView() {
        self.backgroundColor = .appBackgroundColor
        setLabels()
        setTextFields()
    }
    
    private func setLabels() {
        titleLabel.text = "Nova Manuntenção"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: Constants.fontRegular, size: Constants.fontSizeForTitles)
        
        calendarLabel.text = "Selecione a data"
        calendarLabel.textAlignment = .left
        calendarLabel.font = UIFont(name: Constants.fontRegular, size: Constants.fontSizeForSubtitles)
        
        hodometerLabel.text = "Km do veículo"
        hodometerLabel.textAlignment = .left
        hodometerLabel.font = UIFont(name: Constants.fontRegular, size: Constants.fontSizeForSubtitles)
        
        addSubview(titleLabel)
        addSubview(calendarLabel)
        addSubview(hodometerLabel)
        
        setLabelsContraints()
    }
    
    private func setTextFields() {
        calendarTextField.placeholder = "Agosto, 2021"
        hodometerTextField.placeholder = "km/h"
        
        addSubview(calendarTextField)
        addSubview(hodometerTextField)
        
        setTextFieldsContraints()
    }
    
    private func setLabelsContraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 55),
            
            calendarLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            calendarLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            
            hodometerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            hodometerLabel.topAnchor.constraint(equalTo: calendarLabel.bottomAnchor, constant: 100)
        ])
    }
    
    private func setTextFieldsContraints() {
        NSLayoutConstraint.activate([
            calendarTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            calendarTextField.topAnchor.constraint(equalTo: calendarLabel.bottomAnchor, constant: 8),
            
            hodometerTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            hodometerTextField.topAnchor.constraint(equalTo: hodometerLabel.bottomAnchor, constant: 8)
        ])
    }
}

// MARK: - Temporary UIColor extension

extension UIColor {
    
    static var appBackgroundColor: UIColor = {
        return UIColor(displayP3Red: 249/255, green: 251/255, blue: 252/255, alpha: 1)
    }()
    
    static var actionColor: UIColor = {
        return UIColor(displayP3Red: 150/255, green: 121/255, blue: 247/255, alpha: 1)
    }()
    
    static var inactiveColor: UIColor = {
        return .gray
    }()
    
    static var mainColor: UIColor = {
       return UIColor(displayP3Red: 61/255, green: 60/255, blue: 80/255, alpha: 1)
    }()
}
