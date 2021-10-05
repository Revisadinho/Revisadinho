//
//  DateComponent.swift
//  Revisadinho
//
//  Created by Jhennyfer Rodrigues de Oliveira on 14/09/21.
// swiftlint:disable trailing_whitespace line_length weak_delegate

import Foundation
import UIKit

protocol DateComponentActionDelegate: AnyObject {
    func goToPreviousMonth()
    func goToNextMonth()
    
}

protocol ReloadTableViewDelegate: AnyObject {
    func reloadTableViewForPreviousMonth()
    func reloadTableViewForNextMonth()
}

class DateComponent: UIView {
    static var dateComponent = DateComponent()
    let currentDate = DateModel()
    weak var delegateReloadTableView: ReloadTableViewDelegate?
    var delegate: DateComponentActionDelegate = DateComponentController.sharedInstance
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.isUserInteractionEnabled = true
        setUpViewHierarchy()
        setUpDateCardConstraint()
        setUpMonthLabelConstraint()
        setUpYearLabelConstraint()
        setUpForwardButtonConstraint()
        setUpForwardButtonImageConstraint()
        setUpBackButtonConstraint()
        setUpBackButtonImageConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var dateCard: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width*0.9, height: 65))
        view.backgroundColor = .monthCardBackground
        view.layer.cornerRadius = 13
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 13
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.text = currentDate.convertMonthIntToString(monthInt: currentDate.getCurrentMonth())
        label.textColor = .grayText
        label.font = UIFont(name: "Quicksand-Bold", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.textColor = .grayText
        label.font = UIFont(name: "Quicksand-Bold", size: 17)
        label.text = String(currentDate.getCurrentYear())
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var backButtonImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.backward")?.withTintColor(.purpleAction).withRenderingMode(.alwaysOriginal)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var forwardButtonImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "chevron.forward")?.withTintColor(.purpleAction).withRenderingMode(.alwaysOriginal)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(delegatesBackButtonActionToController(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var forwardButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(delegatesForwardButtonActionToController(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func delegatesBackButtonActionToController(sender: UIButton) {
        delegate.goToPreviousMonth()
        delegateReloadTableView?.reloadTableViewForPreviousMonth()
    }
    
    @objc func delegatesForwardButtonActionToController(sender: UIButton) {
        delegate.goToNextMonth()
        delegateReloadTableView?.reloadTableViewForNextMonth()
    }
    
    func setUpViewHierarchy() {
        self.addSubview(dateCard)
        dateCard.addSubview(monthLabel)
        dateCard.addSubview(yearLabel)
        forwardButton.addSubview(forwardButtonImage)
        dateCard.addSubview(forwardButton)
        backButton.addSubview(backButtonImage)
        dateCard.addSubview(backButton)
    }
    
    func setUpDateCardConstraint() {
        NSLayoutConstraint.activate([
            dateCard.widthAnchor.constraint(equalToConstant: dateCard.frame.width),
            dateCard.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
    
    func setUpMonthLabelConstraint() {
        NSLayoutConstraint.activate([
            monthLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            monthLabel.leftAnchor.constraint(equalTo: dateCard.leftAnchor, constant: 16),
            monthLabel.heightAnchor.constraint(equalTo: dateCard.heightAnchor),
            monthLabel.widthAnchor.constraint(equalToConstant: 95)
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
            backButton.heightAnchor.constraint(equalTo: dateCard.heightAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setUpBackButtonImageConstraint() {
        NSLayoutConstraint.activate([
            backButtonImage.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            backButtonImage.centerXAnchor.constraint(equalTo: backButton.centerXAnchor),
            backButtonImage.heightAnchor.constraint(equalToConstant: 26.1),
            backButtonImage.widthAnchor.constraint(equalToConstant: 17)
        ])
    }
    
    func setUpForwardButtonConstraint() {
        NSLayoutConstraint.activate([
            forwardButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            forwardButton.leftAnchor.constraint(equalTo: backButton.rightAnchor, constant: 10),
            forwardButton.rightAnchor.constraint(equalTo: dateCard.rightAnchor, constant: -8),
            forwardButton.heightAnchor.constraint(equalTo: dateCard.heightAnchor),
            forwardButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setUpForwardButtonImageConstraint() {
        NSLayoutConstraint.activate([
            forwardButtonImage.centerYAnchor.constraint(equalTo: forwardButton.centerYAnchor),
            forwardButtonImage.centerXAnchor.constraint(equalTo: forwardButton.centerXAnchor),
            forwardButtonImage.heightAnchor.constraint(equalToConstant: 26.1),
            forwardButtonImage.widthAnchor.constraint(equalToConstant: 17)
        ])
    }
}
