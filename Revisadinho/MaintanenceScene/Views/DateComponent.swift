//
//  DateComponent.swift
//  Revisadinho
//
//  Created by Jhennyfer Rodrigues de Oliveira on 14/09/21.
// swiftlint:disable trailing_whitespace line_length

import Foundation
import UIKit

class DateComponent: UIView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpViewHierarchy()
        setUpDateCardConstraint()
        setUpMonthLabelConstraint()
        setUpYearLabelConstraint()
        setUpBackButtonConstraint()
        setUpForwardButtonConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var dateCard: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 309, height: 55))
        view.backgroundColor = .blue
        view.layer.cornerRadius = 13
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.text = "Dezembro"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.text = "2021"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var forwardButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "chevron.forward"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setUpViewHierarchy() {
        self.addSubview(dateCard)
        dateCard.addSubview(monthLabel)
        dateCard.addSubview(yearLabel)
        dateCard.addSubview(backButton)
        dateCard.addSubview(forwardButton)
    }
    
    func setUpDateCardConstraint() {
        NSLayoutConstraint.activate([
            dateCard.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dateCard.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            dateCard.widthAnchor.constraint(equalToConstant: 309),
            dateCard.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    func setUpMonthLabelConstraint() {
        NSLayoutConstraint.activate([
            monthLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            monthLabel.leftAnchor.constraint(equalTo: dateCard.leftAnchor, constant: 16),
            monthLabel.heightAnchor.constraint(equalTo: dateCard.heightAnchor),
            monthLabel.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    func setUpYearLabelConstraint() {
        NSLayoutConstraint.activate([
            yearLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            yearLabel.leftAnchor.constraint(equalTo: monthLabel.rightAnchor, constant: 8),
            yearLabel.heightAnchor.constraint(equalTo: dateCard.heightAnchor),
            yearLabel.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func setUpBackButtonConstraint() {
        NSLayoutConstraint.activate([
            backButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            backButton.leftAnchor.constraint(equalTo: yearLabel.rightAnchor, constant: 50),
            backButton.heightAnchor.constraint(equalToConstant: 22.1),
            backButton.widthAnchor.constraint(equalToConstant: 13)
        ])
    }
    
    func setUpForwardButtonConstraint() {
        NSLayoutConstraint.activate([
            forwardButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            forwardButton.rightAnchor.constraint(equalTo: dateCard.rightAnchor, constant: -24),
            forwardButton.heightAnchor.constraint(equalToConstant: 22.1),
            forwardButton.widthAnchor.constraint(equalToConstant: 13)
        ])
    }
}
